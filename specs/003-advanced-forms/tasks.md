---
description: "Task list template for feature implementation"
---

# Tasks: UI/UX Advanced Plan + Forms Management

**Input**: Design documents from `/specs/003-advanced-forms/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md

**Tests**: Tests are MANDATORY per the Constitution (TDD principle). Include unit/widget tests for all business logic and core widgets.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Adicionar package `mask_text_input_formatter` ao `pubspec.yaml` (se já não estiver)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T002 Implementar pacote de core validadores (RegEx E-mail, Validador CPF) em `lib/core/validators/form_validators.dart`
- [x] T003 Implementar pacote de formatadores de máscaras (CPF Mask, Telefone Mask dinâmica) em `lib/core/formatters/mask_formatters.dart`
- [x] T004 Atualizar Entidade `Paciente` e Modelos em `lib/domain/entities/paciente.dart` adicionando os campos: telefone, cpf, email, tipo

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - AppFormField (Priority: P1) 🎯 MVP

**Goal**: Criar o componente visual reutilizável de input `AppFormField` e enum de espaçamento dinâmico.

**Independent Test**: Pode ser instanciado sozinho renderizando estilos e exibindo máscaras com sucesso.

### Tests for User Story 1 (MANDATORY per Constitution) ⚠️

- [x] T005 [P] [US1] Criar Widget test para `AppFormField` em `test/presentation/widgets/app_form_field_test.dart`
- [x] T006 [P] [US1] Criar Unit test para o `AppSpacing` em `test/presentation/widgets/app_spacing_test.dart`

### Implementation for User Story 1

- [x] T007 [P] [US1] Presentation: Implementar Enum `AppSpacing` em `lib/presentation/widgets/app_spacing.dart`
- [x] T008 [US1] Presentation: Implementar Widget `AppFormField` robusto incorporando máscaras e validação em `lib/presentation/widgets/app_form_field.dart` (pode engolir/refatorar o anterior `AppInput`)

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - AppButton (Priority: P1)

**Goal**: Centralizar e expandir capacidades do botão base.

**Independent Test**: Botão clica com flutter InkWell feedback visível.

### Tests for User Story 2 (MANDATORY per Constitution) ⚠️

- [x] T009 [P] [US2] Criar Widget test para `AppButton` em `test/presentation/widgets/app_button_test.dart`

### Implementation for User Story 2

- [x] T010 [P] [US2] Presentation: Refinar/Expandir componente `AppButton` em `lib/presentation/widgets/app_button.dart` (garantindo InkWell onTap)

**Checkpoint**: Componentes atômicos prontos para uso em telas.

---

## Phase 5: User Story 3 - Provider de Formulário (PacienteFormCubit) (Priority: P2)

**Goal**: Criar um state manager para isolar todo o gerenciamento de controllers e validação (SRP), erradicando vazamento de memória.

**Independent Test**: Testes unitários do Cubit mockam os controllers e validam respostas síncronas sem depender da tela.

### Tests for User Story 3 (MANDATORY per Constitution) ⚠️

- [x] T011 [P] [US3] Criar Bloc test para validações do `PacienteFormCubit` em `test/presentation/bloc/paciente_form_cubit_test.dart`

### Implementation for User Story 3

- [x] T012 [P] [US3] Presentation: Criar State `PacienteFormState` em `lib/presentation/bloc/paciente_form/paciente_form_state.dart`
- [x] T013 [US3] Presentation: Implementar `PacienteFormCubit` (que instancia seus controllers, mascara dados, valida e aplica dispose() manual) em `lib/presentation/bloc/paciente_form/paciente_form_cubit.dart`

**Checkpoint**: Lógica de formulário extraída perfeitamente da UI.

---

## Phase 6: User Story 4 - Formulário de Paciente com Validação (Priority: P2)

**Goal**: Refatorar `PacienteFormPage` consumindo o novo `PacienteFormCubit`, `AppFormField`s formatados, Regex de email e dropdown de "Tipo".

**Independent Test**: Navegar até a página, digitar "ABC" no campo de CPF e observar falha bloqueante da View informada pelo FormProvider.

### Tests for User Story 4 (MANDATORY per Constitution) ⚠️

- [ ] T014 [P] [US4] Atualizar Widget test da página do form em `test/presentation/pages/paciente_form_page_test.dart`

### Implementation for User Story 4

- [ ] T015 [US4] Presentation: Refatorar `PacienteFormPage` atrelando-a ao `PacienteFormCubit` com `AppFormField`s (incluindo CPF, Telefone, Email) e menu Dropdown de Tipos (`Endodontia`, `Ortodontia`, `Periodontia`) em `lib/presentation/pages/paciente_form_page.dart`

**Checkpoint**: Fluxo completo de formulário com máscaras e validação funcional.

---

## Phase 7: User Story 5 - Refatoração da tela de Login (Priority: P3)

**Goal**: Integrar `AppFormField` e responsividade de desktop ao login original.

**Independent Test**: Max width não ultrapassa 500px quando visualizado numa janela esticada (Web).

### Tests for User Story 5 (MANDATORY per Constitution) ⚠️

- [ ] T016 [P] [US5] Atualizar widget tests responsivos do login em `test/presentation/pages/login_page_test.dart`

### Implementation for User Story 5

- [ ] T017 [US5] Presentation: Atualizar `LoginPage` aplicando `AppFormField`, `AppSpacing` e restrição flexível (`ConstrainedBox 500px`) de acordo com as regras IHC em `lib/presentation/pages/login_page.dart`

**Checkpoint**: Acesso administrativo premium e polido para PC/Mobile.

---

## Phase 8: User Story 6 - Lista de Pacientes Separada (Priority: P3)

**Goal**: Finalizar a Listagem com Botão de Logout superior, listagem organizada com exclusão interativa com modal e título legível.

**Independent Test**: Tentar deletar exibe Modal de Confirmação antes de processar State real.

### Tests for User Story 6 (MANDATORY per Constitution) ⚠️

- [ ] T018 [P] [US6] Atualizar widget tests verificando título fixo e botão de logout em `test/presentation/pages/pacientes_list_page_test.dart`

### Implementation for User Story 6

- [ ] T019 [US6] Presentation: Atualizar título do `PacientesListPage` para "Sistema de Gestão de Pacientes Odontológicos" e injetar ícone botão "Sair"/Logout acionando estado out do App em `lib/presentation/pages/pacientes_list_page.dart`

---

## Phase 9: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T020 Rodar `flutter analyze` para verificar pureza de código limitando a regra SRP e Clean Code
- [ ] T021 Rodar suíte completa `flutter test` garantindo regressão Zero sobre as novas implementações

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed sequentially in priority order (P1 → P2 → P3)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational
- **User Story 2 (P1)**: Can start after Foundational (Independent)
- **User Story 3 (P2)**: Independent logic-wise
- **User Story 4 (P2)**: Depends strictly on US1, US2, and US3 existing before UI refactor
- **User Story 5 (P3)**: Depends on US1, US2
- **User Story 6 (P3)**: Depends on US4 being functional

### Parallel Opportunities

- Todas as validações e testes marcados `[P]` em Foundational, Story 1, 2 e 3 podem começar de forma independente e paralela.
- Modificações das Telas Finais (US4, US5, US6) idealmente após Providers e Forms components estarem solidificados e em branch commitada.

---

## Implementation Strategy

### MVP First (User Story 1 & 2 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL)
3. Build the Forms visually (US1, US2) and test purely structural.

### Incremental Delivery

1. Integrate Cubit `PacienteFormCubit` (US3).
2. Wire logic into the UI via `PacienteFormPage` (US4).
3. Finish off polishing Login Width (US5) and Logout logic (US6).
