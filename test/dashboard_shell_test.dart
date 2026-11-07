import 'package:finsight/app/routes.dart';
import 'package:finsight/core/models/finsight_profile.dart';
import 'package:finsight/features/dashboard/dashboard_tab_placeholder.dart';
import 'package:finsight/shared/navigation/dashboard_shell.dart';
import 'package:finsight/shared/navigation/dashboard_tab.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/finsight_test_utils.dart';

String _tabPath(ProfileType profile, DashboardTab tab) =>
    AppRoutes.profileTab(profile.name, tab.pathSegment);

void main() {
  group('tabs and profile context', () {
    for (final profile in ProfileType.values) {
      testWidgets('${profile.name}: all five tabs keep the profile', (
        tester,
      ) async {
        await pumpFinSight(
          tester,
          initialLocation: AppRoutes.profileDashboard(profile.name),
        );

        // Bare route redirects to Home.
        expect(currentPath(tester), _tabPath(profile, DashboardTab.home));

        for (final tab in DashboardTab.values) {
          await tapTab(tester, tab);

          expectPlaceholder(profile, tab);
          expect(currentPath(tester), _tabPath(profile, tab));
          expect(selectedNavIndex(tester), tab.index);
          expect(tester.takeException(), isNull);
        }
      });
    }

    testWidgets('tabs can be visited in any order', (tester) async {
      await pumpFinSight(
        tester,
        initialLocation: _tabPath(ProfileType.freelancer, DashboardTab.home),
      );

      for (final tab in [
        DashboardTab.coach,
        DashboardTab.pay,
        DashboardTab.plan,
        DashboardTab.home,
        DashboardTab.track,
      ]) {
        await tapTab(tester, tab);

        expectPlaceholder(ProfileType.freelancer, tab);
        expect(currentPath(tester), _tabPath(ProfileType.freelancer, tab));
      }
      expect(tester.takeException(), isNull);
    });

    testWidgets('visited tabs stay alive when switching branches', (
      tester,
    ) async {
      await pumpFinSight(
        tester,
        initialLocation: _tabPath(ProfileType.personal, DashboardTab.home),
      );

      await tapTab(tester, DashboardTab.pay);
      await tapTab(tester, DashboardTab.track);
      await tapTab(tester, DashboardTab.home);

      // Home, Pay and Track are all kept in the IndexedStack, while only
      // the active one is visible.
      expect(
        find.byType(DashboardTabPlaceholder, skipOffstage: false),
        findsAtLeastNWidgets(3),
      );
      expect(find.byType(DashboardTabPlaceholder), findsOneWidget);
      expectPlaceholder(ProfileType.personal, DashboardTab.home);
      expect(tester.takeException(), isNull);
    });
  });

  group('redirects and deep links', () {
    for (final profile in ProfileType.values) {
      testWidgets('bare /dashboard/${profile.name} redirects to Home', (
        tester,
      ) async {
        await pumpFinSight(
          tester,
          initialLocation: AppRoutes.profileDashboard(profile.name),
        );

        expect(currentPath(tester), _tabPath(profile, DashboardTab.home));
        expectPlaceholder(profile, DashboardTab.home);
        expect(tester.takeException(), isNull);
      });
    }

    for (final location in [
      '/dashboard/crypto',
      '/dashboard/crypto/home',
      '/dashboard/Personal/home',
    ]) {
      testWidgets('invalid profile $location goes to profile selection', (
        tester,
      ) async {
        await pumpFinSight(tester, initialLocation: location);

        expect(currentPath(tester), AppRoutes.profileSelection);
        expect(find.text('Choose your profile'), findsOneWidget);
        expect(find.byType(DashboardTabPlaceholder), findsNothing);
        expect(tester.takeException(), isNull);
      });
    }

    for (final profile in ProfileType.values) {
      for (final tab in DashboardTab.values) {
        testWidgets('deep link ${_tabPath(profile, tab)}', (tester) async {
          await pumpFinSight(tester, initialLocation: _tabPath(profile, tab));

          expect(currentPath(tester), _tabPath(profile, tab));
          expectPlaceholder(profile, tab);
          expect(selectedNavIndex(tester), tab.index);
          expect(tester.takeException(), isNull);
        });
      }
    }

    testWidgets('deep link keeps the profile when switching branches', (
      tester,
    ) async {
      await pumpFinSight(
        tester,
        initialLocation: _tabPath(ProfileType.merchant, DashboardTab.plan),
      );

      for (final tab in [DashboardTab.home, DashboardTab.coach]) {
        await tapTab(tester, tab);

        expect(currentPath(tester), _tabPath(ProfileType.merchant, tab));
        expectPlaceholder(ProfileType.merchant, tab);
      }
      expect(tester.takeException(), isNull);
    });
  });

  group('switch profile', () {
    testWidgets('desktop button returns to profile selection', (tester) async {
      await pumpFinSight(
        tester,
        size: TestSizes.desktop,
        initialLocation: _tabPath(ProfileType.business, DashboardTab.track),
      );

      expect(find.text('Switch profile'), findsOneWidget);

      await tester.tap(find.byKey(DashboardShell.switchProfileKey));
      await tester.pumpAndSettle();

      expect(currentPath(tester), AppRoutes.profileSelection);
      expect(find.text('Choose your profile'), findsOneWidget);
      expect(find.byType(DashboardTabPlaceholder), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('tablet icon button returns to profile selection', (
      tester,
    ) async {
      await pumpFinSight(
        tester,
        size: TestSizes.tablet,
        initialLocation: _tabPath(ProfileType.business, DashboardTab.home),
      );

      await tester.tap(find.byKey(DashboardShell.switchProfileKey));
      await tester.pumpAndSettle();

      expect(currentPath(tester), AppRoutes.profileSelection);
      expect(find.text('Choose your profile'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('a different profile starts fresh on every tab', (
      tester,
    ) async {
      await pumpFinSight(tester, size: TestSizes.desktop);
      await completeOnboarding(tester, 'Personal');

      await tapTab(tester, DashboardTab.pay);
      await tapTab(tester, DashboardTab.coach);
      expectPlaceholder(ProfileType.personal, DashboardTab.coach);

      // Switch to Business.
      await tester.tap(find.byKey(DashboardShell.switchProfileKey));
      await tester.pumpAndSettle();
      expect(find.text('Choose your profile'), findsOneWidget);

      await tester.ensureVisible(find.text('Business'));
      await tester.tap(find.text('Business'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Continue'));
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(
        currentPath(tester),
        _tabPath(ProfileType.business, DashboardTab.home),
      );
      expectPlaceholder(ProfileType.business, DashboardTab.home);
      expect(
        tester.widget<Text>(find.byKey(DashboardShell.profileLabelKey)).data,
        'Business',
      );

      // Tabs visited under Personal must not leak into Business.
      for (final tab in [DashboardTab.pay, DashboardTab.coach]) {
        await tapTab(tester, tab);

        expect(currentPath(tester), _tabPath(ProfileType.business, tab));
        expectPlaceholder(ProfileType.business, tab);
      }
      expect(tester.takeException(), isNull);
    });
  });
}
