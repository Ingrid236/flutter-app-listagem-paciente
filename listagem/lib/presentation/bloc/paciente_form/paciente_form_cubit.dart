import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'paciente_form_state.dart';

class PacienteFormCubit extends Cubit<PacienteFormState> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController procedimentoController = TextEditingController();
  final TextEditingController observacoesController = TextEditingController();

  PacienteFormCubit() : super(const PacienteFormState()) {
    nomeController.addListener(_validate);
    cpfController.addListener(_validate);
    telefoneController.addListener(_validate);
    emailController.addListener(_validate);
    procedimentoController.addListener(_validate);
  }

  void _validate() {
    final isValid = nomeController.text.isNotEmpty &&
        cpfController.text.isNotEmpty &&
        telefoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        procedimentoController.text.isNotEmpty &&
        state.selectedTipo != null;
    
    emit(state.copyWith(isFormValid: isValid));
  }

  void updateTipo(String? value) {
    emit(state.copyWith(selectedTipo: value));
    _validate();
  }

  Future<void> submit() async {
    emit(state.copyWith(status: PacienteFormStatus.loading));
    try {
      // Logic for actual submission will be handled in Phase 6/US4 integrating with PacienteCubit
      emit(state.copyWith(status: PacienteFormStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: PacienteFormStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    nomeController.dispose();
    cpfController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    procedimentoController.dispose();
    observacoesController.dispose();
    return super.close();
  }
}
