import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listagem/presentation/pages/paciente_form_page.dart';
import 'package:listagem/presentation/bloc/paciente/paciente_cubit.dart';
import 'package:listagem/domain/entities/paciente.dart';

class MockPacienteCubit extends Mock implements PacienteCubit {}

void main() {
  late MockPacienteCubit mockPacienteCubit;

  setUp(() {
    mockPacienteCubit = MockPacienteCubit();
    when(() => mockPacienteCubit.state).thenReturn(PacienteInitial());
    when(() => mockPacienteCubit.stream).thenAnswer((_) => Stream.fromIterable([PacienteInitial()]));
  });

  Widget createWidgetUnderTest({Paciente? paciente}) {
    return MaterialApp(
      home: BlocProvider<PacienteCubit>.value(
        value: mockPacienteCubit,
        child: PacienteFormPage(paciente: paciente),
      ),
    );
  }

  testWidgets('renders all form fields', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Nome *'), findsOneWidget);
    expect(find.text('CPF *'), findsOneWidget);
    expect(find.text('Telefone *'), findsOneWidget);
    expect(find.text('E-mail *'), findsOneWidget);
    expect(find.text('Tipo de Paciente *'), findsOneWidget);
    expect(find.text('Procedimento *'), findsOneWidget);
  });

  testWidgets('shows validation errors when fields are empty and save is pressed', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Garante que o botão Salvar está visível
    await tester.ensureVisible(find.text('Salvar'));
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Nome é obrigatório'), findsOneWidget);
    expect(find.textContaining('CPF é obrigatório'), findsOneWidget);
    expect(find.textContaining('Telefone é obrigatório'), findsOneWidget);
    expect(find.textContaining('E-mail é obrigatório'), findsOneWidget);
    expect(find.textContaining('Selecione um tipo'), findsOneWidget);
    expect(find.textContaining('Procedimento é obrigatório'), findsOneWidget);
  });
}
