import 'package:flutter_test/flutter_test.dart';
import 'package:listagem/data/models/paciente_model.dart';
import 'package:listagem/domain/entities/paciente.dart';

void main() {
  final tDataAtendimento = DateTime(2026, 4, 6);
  final tPacienteModel = PacienteModel(
    id: '1',
    nome: 'João',
    procedimento: 'Limpeza',
    dataAtendimento: tDataAtendimento,
    observacoes: 'Nenhuma',
  );

  test('should be a subclass of Paciente entity', () {
    expect(tPacienteModel, isA<Paciente>());
  });

  test('fromJson should return a valid model', () {
    final Map<String, dynamic> jsonMap = {
      'id': '1',
      'nome': 'João',
      'procedimento': 'Limpeza',
      'dataAtendimento': tDataAtendimento.toIso8601String(),
      'observacoes': 'Nenhuma',
    };
    final result = PacienteModel.fromJson(jsonMap);
    expect(result, tPacienteModel);
  });

  test('toJson should return a JSON map containing proper data', () {
    final expectedMap = {
      'id': '1',
      'nome': 'João',
      'procedimento': 'Limpeza',
      'dataAtendimento': tDataAtendimento.toIso8601String(),
      'observacoes': 'Nenhuma',
    };
    final result = tPacienteModel.toJson();
    expect(result, expectedMap);
  });
}
