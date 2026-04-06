import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/paciente.dart';
import '../../../domain/usecases/get_pacientes.dart';

import '../../../domain/usecases/add_paciente.dart';
import '../../../domain/usecases/update_paciente.dart';
import '../../../domain/usecases/delete_paciente.dart';

part 'paciente_state.dart';

class PacienteCubit extends Cubit<PacienteState> {
  final GetPacientes getPacientes;
  final AddPaciente addPacienteUseCase;
  final UpdatePaciente updatePacienteUseCase;
  final DeletePaciente deletePacienteUseCase;

  PacienteCubit({
    required this.getPacientes,
    required this.addPacienteUseCase,
    required this.updatePacienteUseCase,
    required this.deletePacienteUseCase,
  }) : super(PacienteInitial());

  Future<void> fetchPacientes() async {
    emit(PacienteLoading());
    try {
      final list = await getPacientes(NoParams());
      emit(PacienteLoaded(list));
    } catch (e) {
      emit(const PacienteError('Falha ao carregar pacientes.'));
    }
  }

  Future<void> addPaciente(Paciente paciente) async {
    emit(PacienteLoading());
    try {
      await addPacienteUseCase(PacienteParams(paciente));
      await fetchPacientes();
    } catch (e) {
      emit(const PacienteError('Falha ao adicionar paciente.'));
    }
  }

  Future<void> updatePaciente(Paciente paciente) async {
    emit(PacienteLoading());
    try {
      await updatePacienteUseCase(PacienteParams(paciente));
      await fetchPacientes();
    } catch (e) {
      emit(const PacienteError('Falha ao atualizar paciente.'));
    }
  }

  Future<void> deletePaciente(String id) async {
    emit(PacienteLoading());
    try {
      await deletePacienteUseCase(DeletePacienteParams(id));
      await fetchPacientes();
    } catch (e) {
      emit(const PacienteError('Falha ao deletar paciente.'));
    }
  }
}
