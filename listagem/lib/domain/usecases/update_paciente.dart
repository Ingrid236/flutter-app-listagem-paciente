import '../../core/usecases/usecase.dart';
import '../repositories/paciente_repository.dart';
import 'add_paciente.dart';

class UpdatePaciente implements UseCase<void, PacienteParams> {
  final PacienteRepository repository;

  UpdatePaciente(this.repository);

  @override
  Future<void> call(PacienteParams params) async {
    return await repository.updatePaciente(params.paciente);
  }
}
