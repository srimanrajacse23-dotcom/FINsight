import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/onboarding/onboarding_placeholder_screen.dart';
import '../features/profile_selection/profile_selection_placeholder_screen.dart';
import '../shared/navigation/app_shell.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const AppShell(
          child: OnboardingPlaceholderScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.profileSelection,
        name: 'profile-selection',
        builder: (context, state) => const AppShell(
          child: ProfileSelectionPlaceholderScreen(),
        ),
      ),
    ],
  );
});

abstract final class AppRoutes {
  static const home = '/';
  static const profileSelection = '/profiles';
}
