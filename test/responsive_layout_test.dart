import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:finsight/app/app.dart';

void main() {
  const sizes = <String, Size>{
    'mobile': Size(360, 800),
    'tablet': Size(768, 1024),
    'desktop': Size(1280, 800),
  };

  sizes.forEach((name, size) {
    testWidgets('no layout errors on $name, full flow', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const ProviderScope(child: FinSightApp()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      // Welcome screen: no hardcoded balance.
      expect(find.text('Get started'), findsOneWidget);
      expect(find.textContaining('12,580'), findsNothing);

      await tester.ensureVisible(find.text('Get started'));
      await tester.tap(find.text('Get started'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      // Profile selection.
      expect(find.text('Choose your profile'), findsOneWidget);
      await tester.ensureVisible(find.text('Merchant'));
      await tester.tap(find.text('Merchant'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Continue'));
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      // Shared placeholder destination.
      expect(find.text('Dashboard coming soon'), findsOneWidget);
      expect(find.text('Switch profile'), findsOneWidget);
    });
  });
}
