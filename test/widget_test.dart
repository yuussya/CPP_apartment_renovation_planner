import 'package:flutter_test/flutter_test.dart';

import 'package:apartment_renovation_planner/app.dart';

void main() {
  testWidgets('Login screen opens dashboard on Sign In', (tester) async {
    await tester.pumpWidget(const RenovationApp());

    expect(find.text('Apartment Planner'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);

    await tester.ensureVisible(find.text('Sign In'));
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Overview'), findsOneWidget);
  });
}
