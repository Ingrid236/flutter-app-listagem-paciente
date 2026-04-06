# Interfaces and Contracts

Uma vez que nossa arquitetura define uma divisão clara (Clean Architecture), os contratos internos que gerenciam a travessia das camadas sem expor implementações devem ser estritamente definidos na camada de Domain.

## Domain Repository Contract (`PacienteRepository`)

A camada `Data` é obrigada a satisfazer esse contrato injetando-se como implementação nas instâncias de UseCase.

```dart
abstract class PacienteRepository {
  /// Retorna lista contínua ou assíncrona dos pacientes armazenados
  Future<List<Paciente>> getAllPacientes();

  /// Adiciona um novo paciente ao armazenamento
  Future<void> addPaciente(Paciente paciente);

  /// Atualiza os dados de um paciente já existente baseado em seu [id]
  Future<void> updatePaciente(Paciente paciente);

  /// Remove com base em seu identificador único [id]
  Future<void> deletePaciente(String id);
}
```

## UseCase Contracts

A camada de Presentation invoca UseCases através de chamadas unicamente funcionais ou Callable Classes (`call`).

```dart
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}
// Outros UseCases não mapeados aqui que não exigem parâmetros (NoParams) usarão uma alternativa genérica similar.
```
