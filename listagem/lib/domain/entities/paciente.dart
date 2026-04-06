import 'package:equatable/equatable.dart';

class Paciente extends Equatable {
  final String id;
  final String nome;
  final String procedimento;
  final String? telefone;
  final String? cpf;
  final String? email;
  final String? tipo;
  final DateTime? dataAtendimento;
  final String? observacoes;

  const Paciente({
    required this.id,
    required this.nome,
    required this.procedimento,
    this.telefone,
    this.cpf,
    this.email,
    this.tipo,
    this.dataAtendimento,
    this.observacoes,
  });

  @override
  List<Object?> get props => [
    id,
    nome,
    procedimento,
    telefone,
    cpf,
    email,
    tipo,
    dataAtendimento,
    observacoes,
  ];
}
