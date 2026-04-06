import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listagem/presentation/bloc/paciente_form/paciente_form_cubit.dart';
import 'package:listagem/presentation/bloc/paciente_form/paciente_form_state.dart';

void main() {
  group('PacienteFormCubit', () {
    late PacienteFormCubit cubit;

    setUp(() {
      cubit = PacienteFormCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, const PacienteFormState());
    });

    blocTest<PacienteFormCubit, PacienteFormState>(
      'emits isFormValid true when all controllers have text and tipo is selected',
      build: () => cubit,
      act: (cubit) {
        cubit.nomeController.text = 'João';
        cubit.cpfController.text = '123.456.789-00';
        cubit.telefoneController.text = '(11) 99999-9999';
        cubit.emailController.text = 'joao@email.com';
        cubit.procedimentoController.text = 'Limpeza';
        cubit.updateTipo('Endodontia');
      },
      expect: () => [
        const PacienteFormState(isFormValid: false), // after nome
        const PacienteFormState(isFormValid: false), // after cpf
        const PacienteFormState(isFormValid: false), // after telefone
        const PacienteFormState(isFormValid: false), // after email
        const PacienteFormState(isFormValid: false), // after procedimento
        const PacienteFormState(isFormValid: true),  // after type selection
      ],
    );

    blocTest<PacienteFormCubit, PacienteFormState>(
      'emits success status when submit is called',
      build: () => cubit,
      act: (cubit) => cubit.submit(),
      expect: () => [
        const PacienteFormState(status: PacienteFormStatus.loading),
        const PacienteFormState(status: PacienteFormStatus.success),
      ],
    );
  });
}
