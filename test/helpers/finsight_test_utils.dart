import 'package:finsight/app/app.dart';
import 'package:finsight/app/router.dart';
import 'package:finsight/core/models/finsight_profile.dart';
import 'package:finsight/features/dashboard/dashboard_tab_placeholder.dart';
import 'package:finsight/shared/navigation/dashboard_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// Logical sizes used across navigation tests.
abstract final class TestSizes {
  static const mobile = Size(390, 844);
  static const smallMobile = Size(320, 568);
  static const tablet = Size(768, 1024);
  static const desktop = Size(1280, 800);
}

/// Pumps the application at the requested screen size.
Future<void> pumpFinSight(
  WidgetTester tester, {
  Size size = TestSizes.mobile,
  String? initialLocation,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        if (initialLocation != null)
          initialLocationProvider.overrideWithValue(initialLocation),
      ],
      child: const FinSightApp(),
    ),
  );

  await tester.pumpAndSettle();
}

/// Reads the GoRouter instance used by the application.
GoRouter routerOf(WidgetTester tester) {
  final container = ProviderScope.containerOf(
    tester.element(find.byType(FinSightApp)),
  );

  return container.read(goRouterProvider);
}

/// Returns the current route path after redirects.
String currentPath(WidgetTester tester) {
  return routerOf(tester).routerDelegate.currentConfiguration.uri.path;
}

Finder get _navBar => find.byType(NavigationBar);
Finder get _navRail => find.byType(NavigationRail);

/// Returns the currently selected navigation index.
int selectedNavIndex(WidgetTester tester) {
  if (_navBar.evaluate().isNotEmpty) {
    return tester.widget<NavigationBar>(_navBar).selectedIndex;
  }

  return tester.widget<NavigationRail>(_navRail).selectedIndex!;
}

/// Taps a dashboard tab in the visible navigation widget.
Future<void> tapTab(WidgetTester tester, DashboardTab tab) async {
  final nav = _navBar.evaluate().isNotEmpty ? _navBar : _navRail;

  final unselected = find.descendant(of: nav, matching: find.byIcon(tab.icon));

  final target = unselected.evaluate().isNotEmpty
      ? unselected
      : find.descendant(of: nav, matching: find.byIcon(tab.selectedIcon));

  await tester.tap(target);
  await tester.pumpAndSettle();
}

/// Checks that the requested profile and tab placeholder is visible.
void expectPlaceholder(ProfileType profile, DashboardTab tab) {
  expect(find.byType(DashboardTabPlaceholder), findsOneWidget);
  expect(
    find.byKey(DashboardTabPlaceholder.keyFor(profile, tab)),
    findsOneWidget,
  );
}

/// Completes onboarding and selects the requested profile.
Future<void> completeOnboarding(
  WidgetTester tester,
  String profileTitle,
) async {
  await tester.ensureVisible(find.text('Get started'));
  await tester.tap(find.text('Get started'));
  await tester.pumpAndSettle();

  await tester.ensureVisible(find.text(profileTitle));
  await tester.tap(find.text(profileTitle));
  await tester.pumpAndSettle();

  await tester.ensureVisible(find.text('Continue'));
  await tester.tap(find.text('Continue'));
  await tester.pumpAndSettle();
}
