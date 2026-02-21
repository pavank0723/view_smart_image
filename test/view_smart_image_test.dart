import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:view_smart_image/view_smart_image.dart';

void main() {
  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('Displays asset image correctly', (tester) async {
    await tester.pumpWidget(
      createWidgetUnderTest(
        const ViewSmartImage(
          path: 'assets/sample.png',
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Displays SVG image correctly', (tester) async {
    await tester.pumpWidget(
      createWidgetUnderTest(
        const ViewSmartImage(
          path: 'assets/sample.svg',
        ),
      ),
    );

    expect(find.byType(SizedBox), findsNothing);
  });

  testWidgets('Applies color when provided', (tester) async {
    await tester.pumpWidget(
      createWidgetUnderTest(
        const ViewSmartImage(
          path: 'assets/sample.png',
          color: Colors.red,
        ),
      ),
    );

    final image = tester.widget<Image>(find.byType(Image));
    expect(image.color, Colors.red);
  });
}