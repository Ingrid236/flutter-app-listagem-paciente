part of 'paciente_cubit.dart';

abstract class PacienteState extends Equatable {
  const PacienteState();

  @override
  List<Object?> get props => [];
}

class PacienteInitial extends PacienteState {}

class PacienteLoading extends PacienteState {}

class PacienteLoaded extends PacienteState {
  final List<Paciente> pacientes;
  const PacienteLoaded(this.pacientes);

  @override
  List<Object?> get props => [pacientes];
}

class PacienteError extends PacienteState {
  final String message;
  const PacienteError(this.message);

  @override
  List<Object?> get props => [message];
}
