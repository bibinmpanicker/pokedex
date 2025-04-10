import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/search/presentation/search_page.dart';

void main() {
  testWidgets('find the [FloatingActionButton]', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ProviderScope(child: SearchPage())),
      ),
    );

    expect(find.byType(FloatingActionButton), findsWidgets);
  });
  testWidgets('find a [Button] having label `Search`', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ProviderScope(child: SearchPage())),
      ),
    );

    expect(find.text('Search'), findsOneWidget); // check it exists
  });

  testWidgets('tap on the logout icon and check whether the popup appears', (
    WidgetTester tester,
  ) async {
    // Build the widget
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ProviderScope(child: SearchPage())),
      ),
    );

    // Tap the delete icon
    await tester.tap(find.byIcon(Icons.power_settings_new_rounded));
    await tester.pumpAndSettle();

    // Verify dialog appears
    expect(find.text('Logout'), findsAny);
  });
}
