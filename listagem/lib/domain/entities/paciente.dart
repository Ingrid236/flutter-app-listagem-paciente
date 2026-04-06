import 'package:equatable/equatable.dart';

class Paciente extends Equatable {
  final String id;
  final String nome;
  final String procedimento;
  final DateTime? dataAtendimento;
  final String? observacoes;

  const Paciente({
    required this.id,
    required this.nome,
    required this.procedimento,
    this.dataAtendimento,
    this.observacoes,
  });

  @override
  List<Object?> get props => [
    id,
    nome,
    procedimento,
    dataAtendimento,
    observacoes,
  ];
}
