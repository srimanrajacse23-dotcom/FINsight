import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:finsight/app/app.dart';
import 'package:finsight/shared/components/finsight_primary_button.dart';

void main() {
  testWidgets('welcome -> profile selection -> profile placeholder', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const ProviderScope(child: FinSightApp()));
    await tester.pumpAndSettle();

    // Welcome screen.
    expect(find.text('Get started'), findsOneWidget);

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    // Profile selection.
    expect(find.text('Choose your profile'), findsOneWidget);
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

    // Shared placeholder destination.
    expect(find.text('Dashboard coming soon'), findsOneWidget);
    expect(find.text('Personal'), findsOneWidget);
    expect(find.text('Switch profile'), findsOneWidget);
  });
}
