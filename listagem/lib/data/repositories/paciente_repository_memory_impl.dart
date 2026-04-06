import 'package:listagem/data/models/paciente_model.dart';
import 'package:listagem/domain/entities/paciente.dart';
import 'package:listagem/domain/repositories/paciente_repository.dart';

class PacienteRepositoryMemoryImpl implements PacienteRepository {
  final List<PacienteModel> _pacientes = [];

  @override
  Future<List<Paciente>> getAllPacientes() async {
    await Future.delayed(const Duration(milliseconds: 100)); // mock lag
    return List<Paciente>.from(_pacientes);
  }

  @override
  Future<void> addPaciente(Paciente paciente) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final model = PacienteModel(
      id: paciente.id,
      nome: paciente.nome,
      procedimento: paciente.procedimento,
      dataAtendimento: paciente.dataAtendimento,
      observacoes: paciente.observacoes,
    );
    _pacientes.add(model);
  }

  @override
  Future<void> updatePaciente(Paciente paciente) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _pacientes.indexWhere((p) => p.id == paciente.id);
    if (index != -1) {
      _pacientes[index] = PacienteModel(
        id: paciente.id,
        nome: paciente.nome,
        procedimento: paciente.procedimento,
        dataAtendimento: paciente.dataAtendimento,
        observacoes: paciente.observacoes,
      );
    }
  }

  @override
  Future<void> deletePaciente(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _pacientes.removeWhere((p) => p.id == id);
  }

  // Helper method exclusively for testing or seeding
  void seed(PacienteModel model) {
    _pacientes.add(model);
  }

  void clear() {
    _pacientes.clear();
  }
}
