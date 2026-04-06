import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listagem/presentation/widgets/app_button.dart';

void main() {
  testWidgets('AppButton should render text and be clickable', (WidgetTester tester) async {
    bool clicked = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            text: 'Clique Aqui',
            onPressed: () => clicked = true,
          ),
        ),
      ),
    );

    expect(find.text('Clique Aqui'), findsOneWidget);
    await tester.tap(find.byType(AppButton));
    expect(clicked, true);
  });

  testWidgets('AppButton should show icon when provided', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppButton(
            text: 'Com Ícone',
            icon: Icons.add,
            onPressed: null,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
