import '../../core/usecases/usecase.dart';
import '../entities/paciente.dart';
import '../repositories/paciente_repository.dart';

class AddPaciente implements UseCase<void, PacienteParams> {
  final PacienteRepository repository;

  AddPaciente(this.repository);

  @override
  Future<void> call(PacienteParams params) async {
    return await repository.addPaciente(params.paciente);
  }
}

class PacienteParams {
  final Paciente paciente;
  PacienteParams(this.paciente);
}
