/// Route path constants. This file has no imports on purpose, so any
/// screen or the router can import it without creating a circular import.
abstract final class AppRoutes {
  static const home = '/';
  static const profileSelection = '/profiles';

  /// Base path for profile destinations.
  static const profileDashboardBase = '/dashboard';

  /// Name of the profile path parameter.
  static const profileDashboardParam = 'profile';

  /// Matches the profile dashboard route.
  static const profileDashboardPattern =
      '$profileDashboardBase/:$profileDashboardParam';

  // Dashboard tab path segments.
  static const tabHome = 'home';
  static const tabPay = 'pay';
  static const tabTrack = 'track';
  static const tabPlan = 'plan';
  static const tabCoach = 'coach';

  /// Returns `/dashboard/<profile>`.
  static String profileDashboard(String profile) =>
      '$profileDashboardBase/$profile';

  /// Returns `/dashboard/<profile>/<tab>`.
  static String profileTab(String profile, String tabSegment) =>
      '${profileDashboard(profile)}/$tabSegment';
}
