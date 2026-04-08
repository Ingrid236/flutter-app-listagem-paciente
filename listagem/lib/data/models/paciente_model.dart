import '../../domain/entities/paciente.dart';

class PacienteModel extends Paciente {
  const PacienteModel({
    required super.id,
    required super.nome,
    required super.procedimento,
    super.telefone,
    super.cpf,
    super.email,
    super.tipo,
    super.dataAtendimento,
    super.observacoes,
  });

  factory PacienteModel.fromJson(Map<String, dynamic> json) {
    return PacienteModel(
      id: json['id'],
      nome: json['nome'],
      procedimento: json['procedimento'],
      telefone: json['telefone'],
      cpf: json['cpf'],
      email: json['email'],
      tipo: json['tipo'],
      dataAtendimento: json['dataAtendimento'] != null
          ? DateTime.parse(json['dataAtendimento'])
          : null,
      observacoes: json['observacoes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'procedimento': procedimento,
      'telefone': telefone,
      'cpf': cpf,
      'email': email,
      'tipo': tipo,
      'dataAtendimento': dataAtendimento?.toIso8601String(),
      'observacoes': observacoes,
    };
  }
}
