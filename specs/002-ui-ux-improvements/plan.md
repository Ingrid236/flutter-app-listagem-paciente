# Implementation Plan: UI/UX Improvements

**Branch**: `002-ui-ux-improvements` | **Date**: 2026-04-06 | **Spec**: [spec.md](file:///c:/mobile/flutter-app-listagem/specs/002-ui-ux-improvements/spec.md)
**Input**: Feature specification from `/specs/002-ui-ux-improvements/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Padronização de botões, inputs, tipografia e estrutura visual geral sem alterar regras de negócio. O trabalho será concentrado em componentes reutilizáveis utilizando a paleta azul focada em Light Mode, injeção de ThemeData no widget app principal, e estilização do fluxo de login e do formulário via Presentation pattern, sem violar as amarras de UseCases da Clean Architecture.

## Technical Context

**Language/Version**: Dart 3+, Flutter 3+  
**Primary Dependencies**: Flutter Material, flutter_bloc  
**Storage**: N/A (In-memory mock logic preserved)  
**Testing**: flutter_test, mocktail  
**Target Platform**: Android, iOS, Web  
**Project Type**: Mobile Application  
**Performance Goals**: Layout renderization 60 FPS, Web layout adaptation sem lags de resize  
**Constraints**: ThemeData global imposto, Mobile-first flexível p/ Desktop via width limiter  
**Scale/Scope**: Todas as telas do app listagem (Login, Listagem, Form)  

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- [x] Camadas separadas corretamente (Presentation, Domain, Data, Core). -> Operando puramente em Presentation/Widgets.
- [x] UI isolada e limpa (Nenhuma regra de negócio na UI, nenhum acesso direto ao repositório). -> Os Bloc/Cubits continuarão instanciando lógicas transparentemente.
- [x] Operações executadas via UseCases (e.g., GetPacientes, AddPaciente). -> Preservados.
- [x] Persistência inicial em memória (Sem BD real na Fase 1, mas preparado para mock). -> Preservada.
- [x] Reutilização implementada (Campos, Botões, Dialogs componentes extraídos). -> **Este é o core da feature**, criando diretórios de reusable custom widgets.

## Project Structure

### Documentation (this feature)

```text
specs/002-ui-ux-improvements/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
listagem/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   └── theme/
│   │       ├── app_theme.dart     # Novo Theme Blue Hierarchy
│   │       └── colors.dart
│   ├── presentation/
│   │   ├── widgets/
│   │   │   ├── app_button.dart
│   │   │   ├── app_input.dart
│   │   │   └── app_card.dart
│   │   └── pages/
│   │       ├── login_page.dart
│   │       ├── pacientes_list_page.dart
│   │       └── paciente_form_page.dart
```

**Structure Decision**: Adotar o container `/core/theme/` para gerenciar estáticos de fonte e cor, enquanto agrupamos peças puramente UI no repositório já ativo `/presentation/widgets/`.

## Complexity Tracking

*No Constitution violations found. No active workarounds.*
