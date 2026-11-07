import 'package:finsight/app/routes.dart';
import 'package:finsight/core/models/finsight_profile.dart';
import 'package:finsight/shared/components/finsight_primary_button.dart';
import 'package:finsight/shared/navigation/dashboard_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/finsight_test_utils.dart';

void main() {
  testWidgets('welcome -> profile selection -> dashboard', (tester) async {
    await pumpFinSight(tester, size: const Size(390, 1600));

    // Welcome screen.
    expect(find.text('Get started'), findsOneWidget);
    expect(currentPath(tester), AppRoutes.home);

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    // Profile selection.
    expect(find.text('Choose your profile'), findsOneWidget);
    expect(currentPath(tester), AppRoutes.profileSelection);
    expect(find.text('Personal'), findsOneWidget);
    expect(find.text('Business'), findsOneWidget);
    expect(find.text('Freelancer / Professional'), findsOneWidget);
    expect(find.text('Merchant'), findsOneWidget);

    final continueFinder = find.widgetWithText(
      FinsightPrimaryButton,
      'Continue',
    );

    expect(
      tester.widget<FinsightPrimaryButton>(continueFinder).onPressed,
      isNull,
    );

    // Select Personal.
    await tester.tap(find.text('Personal'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<FinsightPrimaryButton>(continueFinder).onPressed,
      isNotNull,
    );

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // The bare /dashboard/personal route lands on the Home tab.
    expect(
      currentPath(tester),
      AppRoutes.profileTab('personal', AppRoutes.tabHome),
    );
    expectPlaceholder(ProfileType.personal, DashboardTab.home);
    expect(find.text('Personal dashboard'), findsOneWidget);
    expect(find.text('FINsight · Simulated environment'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
