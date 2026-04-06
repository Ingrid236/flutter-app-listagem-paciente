import '../entities/paciente.dart';

abstract class PacienteRepository {
  Future<List<Paciente>> getAllPacientes();
  Future<void> addPaciente(Paciente paciente);
  Future<void> updatePaciente(Paciente paciente);
  Future<void> deletePaciente(String id);
}
