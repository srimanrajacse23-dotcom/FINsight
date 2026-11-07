import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/models/finsight_profile.dart';
import '../features/dashboard/dashboard_tab_placeholder.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/profile_selection/profile_selection_screen.dart';
import '../shared/navigation/app_shell.dart';
import '../shared/navigation/dashboard_shell.dart';
import '../shared/navigation/dashboard_tab.dart';
import 'routes.dart';

/// Location the router starts on. Tests override this to simulate deep links.
final initialLocationProvider = Provider<String>((ref) => AppRoutes.home);

final goRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: ref.read(initialLocationProvider),
    redirect: _redirectInvalidProfile,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) =>
            const AppShell(showBottomWaves: true, child: OnboardingScreen()),
      ),
      GoRoute(
        path: AppRoutes.profileSelection,
        name: 'profile-selection',
        builder: (context, state) =>
            const AppShell(child: ProfileSelectionScreen()),
      ),

      // Each profile has its own static route group.
      // This avoids parameterized StatefulShellBranch default locations.
      for (final profile in ProfileType.values)
        GoRoute(
          path: AppRoutes.profileDashboard(profile.name),
          redirect: (context, state) {
            // A bare profile URL opens its Home tab.
            if (state.uri.path == AppRoutes.profileDashboard(profile.name)) {
              return AppRoutes.profileTab(profile.name, AppRoutes.tabHome);
            }

            return null;
          },
          routes: [
            StatefulShellRoute.indexedStack(
              builder: (context, state, navigationShell) {
                return DashboardShell(
                  navigationShell: navigationShell,
                  profile: profile,
                );
              },
              branches: [
                for (final tab in DashboardTab.values)
                  StatefulShellBranch(
                    routes: [
                      GoRoute(
                        path: tab.pathSegment,
                        name: 'dashboard-${profile.name}-${tab.name}',
                        builder: (context, state) {
                          return DashboardTabPlaceholder(
                            tab: tab,
                            profile: profile,
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
    ],
  );

  ref.onDispose(router.dispose);

  return router;
});

/// Sends dashboard URLs with an unknown profile name to profile selection.
String? _redirectInvalidProfile(BuildContext context, GoRouterState state) {
  final path = state.uri.path;
  const base = AppRoutes.profileDashboardBase;

  if (path != base && !path.startsWith('$base/')) {
    return null;
  }

  final segments = state.uri.pathSegments;

  final profile = segments.length > 1
      ? ProfileType.tryParse(segments[1])
      : null;

  return profile == null ? AppRoutes.profileSelection : null;
}
