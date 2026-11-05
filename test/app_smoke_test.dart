import 'package:finsight/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FINsight app bootstraps and shows onboarding placeholder', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FinSightApp()));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to FINsight'), findsOneWidget);
    expect(find.text('Continue to Profile Selection'), findsOneWidget);
  });
}
