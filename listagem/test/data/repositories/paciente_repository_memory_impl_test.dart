import 'package:flutter_test/flutter_test.dart';
import 'package:listagem/data/models/paciente_model.dart';
import 'package:listagem/data/repositories/paciente_repository_memory_impl.dart';

void main() {
  late PacienteRepositoryMemoryImpl repository;

  setUp(() {
    repository = PacienteRepositoryMemoryImpl();
  });

  final tPaciente = PacienteModel(
    id: '1',
    nome: 'João',
    procedimento: 'Limpeza',
  );

  test('getAllPacientes should return an empty list initially', () async {
    final result = await repository.getAllPacientes();
    expect(result, isEmpty);
  });

  test(
    'addPaciente should add the item and getAllPacientes should list it',
    () async {
      await repository.addPaciente(tPaciente);
      final result = await repository.getAllPacientes();
      expect(result.length, 1);
      expect(result.first.id, '1');
    },
  );

  test('updatePaciente should modify existing properties', () async {
    await repository.addPaciente(tPaciente);
    final tUpdated = PacienteModel(
      id: '1',
      nome: 'João Silva',
      procedimento: 'Extração',
    );
    await repository.updatePaciente(tUpdated);
    final result = await repository.getAllPacientes();
    expect(result.first.nome, 'João Silva');
    expect(result.first.procedimento, 'Extração');
  });

  test('deletePaciente should remove the item from the list', () async {
    await repository.addPaciente(tPaciente);
    await repository.deletePaciente('1');
    final result = await repository.getAllPacientes();
    expect(result, isEmpty);
  });
}
