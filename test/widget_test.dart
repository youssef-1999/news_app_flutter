import 'package:flutter_test/flutter_test.dart';

import 'package:news_app/main.dart';

void main() {
  testWidgets('App starts on the home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const NewsApp());

    expect(find.text('Home'), findsOneWidget);
  });
}
