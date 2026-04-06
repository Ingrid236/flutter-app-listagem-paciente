import '../../core/usecases/usecase.dart';
import '../entities/paciente.dart';
import '../repositories/paciente_repository.dart';

class GetPacientes implements UseCase<List<Paciente>, NoParams> {
  final PacienteRepository repository;

  GetPacientes(this.repository);

  @override
  Future<List<Paciente>> call(NoParams params) async {
    return await repository.getAllPacientes();
  }
}
