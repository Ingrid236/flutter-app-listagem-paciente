# Implementation Plan: Pacientes CRUD

**Branch**: `001-pacientes-crud` | **Date**: 2026-04-06 | **Spec**: [specs/001-pacientes-crud/spec.md](spec.md)
**Input**: Feature specification from `/specs/001-pacientes-crud/spec.md`

## Summary

O objetivo principal desta feature é entregar uma aplicação de sistema de gestão de pacientes para dispositivos móveis garantindo a aplicação estrita do Clean Architecture. Tudo será operado sob um banco de dados em memória volátil, gerenciado através do BLoC, fornecendo as funcionalidades de CRUD clássicas sob entidades puras e UseCases isolados para garantir que futuras atualizações passem ilesas em eventuais inserções de banco de dados nativos na camada de Data.

## Technical Context

**Language/Version**: Dart 3.x (Flutter)
**Primary Dependencies**: `flutter_bloc` (Gerenciamento de Estado), `equatable` (Comparações de Models/Entities), `intl` (Formatação de Datas).
**Storage**: N/A (Repositório Falso em Memória Runtime).
**Testing**: `flutter_test`, `bloc_test`, `mocktail` (Para simulações de UseCases/Repositories nos testes).
**Target Platform**: Mobile (iOS / Android)
**Project Type**: mobile-app
**Performance Goals**: Renderização de listas em 60 FPS (menos de 16ms por frame).
**Constraints**: Puramente local, perda instantânea de dados com app kill, UI estrita sem conexões com o `data` source.
**Scale/Scope**: < 100 pacientes para demonstração interativa mock; 3-4 telas.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- [x] Camadas separadas corretamente (Presentation, Domain, Data, Core).
- [x] UI isolada e limpa (Nenhuma regra de negócio na UI, nenhum acesso direto ao repositório).
- [x] Operações executadas via UseCases (e.g., GetPacientes, AddPaciente).
- [x] Persistência inicial em memória (Sem BD real na Fase 1, mas preparado para mock).
- [x] Reutilização implementada (Campos, Botões, Dialogs componentes extraídos).

## Project Structure

### Documentation (this feature)

```text
specs/001-pacientes-crud/
├── plan.md              # This file
├── research.md          # Technology decisions
├── data-model.md        # Feature Data Scheme
├── quickstart.md        # Environment instructions
├── contracts/           # Internal Interfaces
│   └── domain_contracts.md
└── tasks.md             # Development Tasks Step-by-Step
```

### Source Code (repository root)

```text
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── usecases/
│   └── utils/
├── data/
│   ├── models/
│   │   └── paciente_model.dart
│   └── repositories/
│       └── paciente_repository_memory_impl.dart
├── domain/
│   ├── entities/
│   │   └── paciente.dart
│   ├── repositories/
│   │   └── paciente_repository.dart
│   └── usecases/
│       ├── add_paciente.dart
│       ├── delete_paciente.dart
│       ├── get_pacientes.dart
│       ├── login_user.dart
│       └── update_paciente.dart
└── presentation/
    ├── bloc/
    │   ├── auth/
    │   └── paciente/
    ├── pages/
    │   ├── login_page.dart
    │   ├── pacientes_list_page.dart
    │   └── paciente_form_page.dart
    └── widgets/
        ├── shared_text_field.dart
        └── shared_confirmation_dialog.dart

tests/
├── data/
├── domain/
└── presentation/
```

**Structure Decision**: A estrutura foi dividida seguindo exatamente o Clean Architecture no padrão de Pastas por Camadas. Módulos de domínio, dados e apresentação estão estritamente confinados, assim como o `core/` abrigará lógicas universais como `Failure` e `UseCase` abstratos.

## Complexity Tracking

Não existem violações dos mandatos da Constituição atuais, portanto, a complexidade não excede os limites de aceitação impostos.
