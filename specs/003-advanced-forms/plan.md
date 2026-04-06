# Implementation Plan: UI/UX Advanced Plan + Forms Management

**Branch**: `003-advanced-forms` | **Date**: 2026-04-06 | **Spec**: specs/003-advanced-forms/spec.md
**Input**: Feature specification from `/specs/003-advanced-forms/spec.md`

## Summary

Implement advanced forms management using `flutter_bloc` (Provider standard) for isolation, integrated structured masking (CPF, Telefone), built-in Regex (Email), and reusable UI widgets (`AppFormField`, `AppSpacing`). Enhances UX and guarantees strict Clean Architecture boundaries with IHC guidelines.

## Technical Context

**Language/Version**: Dart 3+, Flutter 3.29+ 
**Primary Dependencies**: `flutter_bloc`, `mask_text_input_formatter` (if installed, or native text formatters)
**Storage**: In-memory (Mock)
**Testing**: `flutter test`
**Target Platform**: Android, iOS, Web
**Project Type**: Mobile App
**Performance Goals**: 0 Memory Leaks (Proper Controller disposes mapped securely)
**Constraints**: 100% boundary isolation; no direct validations inside UI layer.

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
specs/003-advanced-forms/
├── plan.md              # This file (/speckit-plan command output)
├── research.md          # Phase 0 output (/speckit-plan command)
├── data-model.md        # Phase 1 output (/speckit-plan command)
├── quickstart.md        # Phase 1 output (/speckit-plan command)
└── tasks.md             # Phase 2 output (/speckit-tasks command)
```

### Source Code (repository root)

```text
lib/
├── core/
│   ├── formatters/
│   │   └── mask_formatters.dart
│   └── validators/
│       └── form_validators.dart
└── presentation/
    ├── bloc/
    │   └── paciente_form/
    │       ├── paciente_form_cubit.dart
    │       └── paciente_form_state.dart
    ├── widgets/
    │   ├── app_form_field.dart
    │   ├── app_spacing.dart
    │   └── ...
    └── pages/
        ├── paciente_form_page.dart
        └── login_page.dart
```

**Structure Decision**: The logic will be broken down according to Clean Code and SRP principles. Form state will go into a dedicated feature bloc inside presentation. Validations and reusable masks will exist globally under `lib/core/` to ensure reusability outside of just the Presentation logic.
