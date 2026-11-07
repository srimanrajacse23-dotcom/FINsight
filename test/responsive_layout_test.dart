import 'package:finsight/core/models/finsight_profile.dart';
import 'package:finsight/shared/components/finsight_wordmark.dart';
import 'package:finsight/shared/navigation/dashboard_shell.dart';
import 'package:finsight/shared/navigation/dashboard_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/finsight_test_utils.dart';

void main() {
  group('full flow renders without errors', () {
    const sizes = <String, Size>{
      'mobile': Size(360, 800),
      'tablet': TestSizes.tablet,
      'desktop': TestSizes.desktop,
    };

    sizes.forEach((name, size) {
      testWidgets('on $name', (tester) async {
        await pumpFinSight(tester, size: size);
        expect(tester.takeException(), isNull);

        // Welcome screen.
        expect(find.text('Get started'), findsOneWidget);
        expect(find.textContaining('12,580'), findsNothing);

        await completeOnboarding(tester, 'Merchant');
        expect(tester.takeException(), isNull);

        // Merchant dashboard.
        expectPlaceholder(ProfileType.merchant, DashboardTab.home);
        expect(find.text('Merchant dashboard'), findsOneWidget);
        expect(find.text('FINsight · Simulated environment'), findsOneWidget);

        // Every tab renders without layout errors at this size.
        for (final tab in DashboardTab.values) {
          await tapTab(tester, tab);
          expectPlaceholder(ProfileType.merchant, tab);
          expect(tester.takeException(), isNull);
        }
      });
    });
  });

  group('navigation widget per form factor', () {
    testWidgets('mobile shows a NavigationBar', (tester) async {
      await pumpFinSight(tester, initialLocation: '/dashboard/personal/home');

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);

      final bar = tester.widget<NavigationBar>(find.byType(NavigationBar));
      expect(bar.destinations, hasLength(DashboardTab.values.length));

      for (final tab in DashboardTab.values) {
        expect(
          find.descendant(
            of: find.byType(NavigationBar),
            matching: find.text(tab.label),
          ),
          findsOneWidget,
        );
      }
      expect(tester.takeException(), isNull);
    });

    testWidgets('tablet shows a compact NavigationRail', (tester) async {
      await pumpFinSight(
        tester,
        size: TestSizes.tablet,
        initialLocation: '/dashboard/personal/home',
      );

      expect(find.byType(NavigationBar), findsNothing);
      expect(find.byType(NavigationRail), findsOneWidget);

      final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
      expect(rail.extended, isFalse);
      expect(rail.labelType, NavigationRailLabelType.selected);
      expect(rail.destinations, hasLength(DashboardTab.values.length));

      // The wordmark and the profile label are desktop-only.
      expect(find.byKey(DashboardShell.profileLabelKey), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('desktop shows an extended NavigationRail', (tester) async {
      await pumpFinSight(
        tester,
        size: TestSizes.desktop,
        initialLocation: '/dashboard/personal/home',
      );

      expect(find.byType(NavigationBar), findsNothing);
      expect(find.byType(NavigationRail), findsOneWidget);

      final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
      expect(rail.extended, isTrue);
      expect(rail.destinations, hasLength(DashboardTab.values.length));

      // Wordmark, all labels, profile label and Switch profile are shown.
      expect(
        find.descendant(
          of: find.byType(NavigationRail),
          matching: find.byType(FinsightWordmark),
        ),
        findsOneWidget,
      );
      for (final tab in DashboardTab.values) {
        expect(
          find.descendant(
            of: find.byType(NavigationRail),
            matching: find.text(tab.label),
          ),
          findsOneWidget,
        );
      }
      expect(
        tester.widget<Text>(find.byKey(DashboardShell.profileLabelKey)).data,
        'Personal',
      );
      expect(find.text('Switch profile'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('breakpoints', () {
    // width, expects NavigationBar, expects extended rail.
    const cases = <(double, bool, bool)>[
      (320, true, false),
      (599, true, false),
      (600, false, false),
      (1023, false, false),
      (1024, false, true),
    ];

    for (final (width, expectsBar, expectsExtended) in cases) {
      testWidgets('width $width', (tester) async {
        await pumpFinSight(
          tester,
          size: Size(width, 900),
          initialLocation: '/dashboard/business/track',
        );

        expect(
          find.byType(NavigationBar),
          expectsBar ? findsOneWidget : findsNothing,
        );
        expect(
          find.byType(NavigationRail),
          expectsBar ? findsNothing : findsOneWidget,
        );

        if (!expectsBar) {
          final rail = tester.widget<NavigationRail>(
            find.byType(NavigationRail),
          );
          expect(rail.extended, expectsExtended);
        }

        expectPlaceholder(ProfileType.business, DashboardTab.track);
        expect(tester.takeException(), isNull);
      });
    }
  });
}
