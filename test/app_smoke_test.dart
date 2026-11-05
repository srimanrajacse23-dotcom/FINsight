import 'package:finsight/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FINsight app bootstraps and navigates from onboarding', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FinSightApp()));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to FINsight'), findsOneWidget);
    expect(find.text('Continue to Profile Selection'), findsOneWidget);

    await tester.tap(find.text('Continue to Profile Selection'));
    await tester.pumpAndSettle();

    expect(find.text('Choose your profile'), findsOneWidget);
    expect(find.text('Personal / Individual'), findsOneWidget);
  });
}
