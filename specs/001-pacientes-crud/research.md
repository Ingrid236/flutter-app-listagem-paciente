# Research & Design Decisions: Pacientes CRUD

## Decision 1: UI State Management Library
- **Decision**: `flutter_bloc`
- **Rationale**: Forçado pelo processo de Constituição; é a biblioteca dominante para lidar com separação estrita em arquiteturas limpas com Flutter. Mantém eventos que emanam da UI desacoplados das execuções de UseCases, mantendo a responsabilidade bem desenhada.
- **Alternatives considered**: `provider`, `riverpod` e `getx` (Rejeitados pelas diretrizes da spec).

## Decision 2: In-Memory Datastore Implementation
- **Decision**: Uso estático/Singleton de um `List<PacienteModel>` dentro do `PacienteRepositoryMemoryImpl`.
- **Rationale**: Imposto diretamente pelas diretrizes da spec que proíbe banco de dados atrelados. Uma lista em um padrão Singleton ou injetada no Top-Level do Repo permite CRUD com atualizações rápidas, emulando perfeitamente transações síncronas/assíncronas comuns a bases reais (permitindo fácil modificação retornável com `Future.delayed`).
- **Alternatives considered**: `Hive` e `SQLite` (Rejeitados pelas restrições do MVP).

## Decision 3: Entity Comparison Equality
- **Decision**: `equatable`
- **Rationale**: No Clean Architecture as entidades trafegam por várias camadas e o BLoC baseia sua refatoração de widget tree através da diferenciação de States. Equatable viabiliza comparar instâncias de States e de classes `Paciente` e `PacienteModel` sem sobreescrever manualmente `hashCode` e operador `==`.
- **Alternatives considered**: Freezed (muito intrusiva na geração de código para um projeto sem banco complexo), Sobrescrição manual nativa (propenso a erros).
