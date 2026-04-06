import 'package:equatable/equatable.dart';

enum PacienteFormStatus { initial, loading, success, failure }

class PacienteFormState extends Equatable {
  final PacienteFormStatus status;
  final bool isFormValid;
  final String? errorMessage;
  final String? selectedTipo;

  const PacienteFormState({
    this.status = PacienteFormStatus.initial,
    this.isFormValid = false,
    this.errorMessage,
    this.selectedTipo,
  });

  PacienteFormState copyWith({
    PacienteFormStatus? status,
    bool? isFormValid,
    String? errorMessage,
    String? selectedTipo,
  }) {
    return PacienteFormState(
      status: status ?? this.status,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedTipo: selectedTipo ?? this.selectedTipo,
    );
  }

  @override
  List<Object?> get props => [status, isFormValid, errorMessage, selectedTipo];
}
