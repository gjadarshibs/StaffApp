import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loading_indicator/loading_indicator.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.

  Widget createWidgetForTesting({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Loading indicator with message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.

    final testWidget = createWidgetForTesting(child: LoadingIndicator(loadingMessage: 'Loading'));
    await tester.pumpWidget(testWidget);

    // Create the Finders.
    final messageFinder = find.text('Loading');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(messageFinder, findsOneWidget);

    // Get Find reference and get a CircularProgressIndicator type for assert it.
    final circularProgressIndicator = find.byType(CircularProgressIndicator);

    // We expect there is only one circularProgressIndicator in view.
    expect(circularProgressIndicator, findsOneWidget);

  });

  testWidgets('Loading indicator with gif image', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.

    final testWidget = createWidgetForTesting(child: LoadingIndicator(loadingMessage: 'Loading'));
    await tester.pumpWidget(testWidget);

    // Create the Finders.
    final messageFinder = find.text('Loading');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(messageFinder, findsOneWidget);
  });
}
