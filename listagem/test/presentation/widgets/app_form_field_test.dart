import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listagem/presentation/widgets/app_form_field.dart';

void main() {
  testWidgets('AppFormField should render label and hint', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppFormField(
            label: 'Nome',
            hintText: 'Digite o nome do paciente',
          ),
        ),
      ),
    );

    expect(find.text('Nome'), findsOneWidget);
    expect(find.text('Digite o nome do paciente'), findsOneWidget);
  });

  testWidgets('AppFormField should show error message when validator returns string', (WidgetTester tester) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: AppFormField(
              label: 'Email',
              validator: (value) => 'Email inválido',
            ),
          ),
        ),
      ),
    );

    formKey.currentState!.validate();
    await tester.pump();

    expect(find.text('Email inválido'), findsOneWidget);
  });
}
