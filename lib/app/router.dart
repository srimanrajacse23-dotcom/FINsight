import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/models/finsight_profile.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/profile_home/profile_placeholder_screen.dart';
import '../features/profile_selection/profile_selection_screen.dart';
import '../shared/navigation/app_shell.dart';
import 'routes.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
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
      GoRoute(
        path: AppRoutes.profileDashboardPattern,
        name: 'profile-dashboard',
        redirect: (context, state) {
          final name = state.pathParameters[AppRoutes.profileDashboardParam];

          final valid = ProfileType.values.any((type) => type.name == name);

          return valid ? null : AppRoutes.profileSelection;
        },
        builder: (context, state) {
          final name = state.pathParameters[AppRoutes.profileDashboardParam];

          final type = ProfileType.values.firstWhere(
            (profileType) => profileType.name == name,
          );

          return AppShell(child: ProfilePlaceholderScreen(type: type));
        },
      ),
    ],
  );
});
