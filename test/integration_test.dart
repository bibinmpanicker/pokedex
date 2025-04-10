import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pokedex/features/search/presentation/search_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'user clicks on `Surprise Me!` button and see the result appears',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: ProviderScope(child: SearchPage())),
        ),
      );
      await tester.pumpAndSettle();

      final surpriseButton = find.text('Surprise Me!');
      expect(surpriseButton, findsOneWidget);

      await tester.tap(surpriseButton);
      await tester.pumpAndSettle();
      // Step 3: Check when the `Add tom Pokedex` icon appears.
      expect(find.byIcon(Icons.power_settings_new_rounded), findsAny);
    },
  );
}
