import '../../core/usecases/usecase.dart';
import '../repositories/paciente_repository.dart';

class DeletePaciente implements UseCase<void, DeletePacienteParams> {
  final PacienteRepository repository;

  DeletePaciente(this.repository);

  @override
  Future<void> call(DeletePacienteParams params) async {
    return await repository.deletePaciente(params.id);
  }
}

class DeletePacienteParams {
  final String id;
  DeletePacienteParams(this.id);
}
