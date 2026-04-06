# Implementation Tasks: Melhoria de UI/UX para CRUD de Pacientes

**Feature Branch**: `002-ui-ux-improvements`
**Created**: 2026-04-06
**Status**: Ready

## Phase 1: Setup & Foundational
Goal: Estabelecer as bases estáticas (cores e tipografia nativa) para consumo nos componentes universais.

- [x] T001 Configurar paleta de cores azuis em `lib/core/theme/colors.dart`
- [x] T002 Expor o tema light padronizado (`AppTheme.light`) em `lib/core/theme/app_theme.dart`

---

## Phase 2: US1 - Padronização do Tema Global
**Story Goal**: Implementar base visual mais atraente e prevenir falhas de estilo despadronizado entre telas, ocultar barra de debug.
**Independent Test**: App base exibe cor primária azul em appBar nativas sem configurações individuais de cor na tela e está livre da barra "DEBUG" nativa.

- [x] T003 [US1] Aplicar `AppTheme.light` na propriedade `theme` do `MaterialApp` e ativar `debugShowCheckedModeBanner: false` em `lib/main.dart`. Atualizar o setup de testes `test/widget_test.dart` no wrapper caso afete instâncias, focando em NFR-003.

---

## Phase 3: US2 - Componentes Universais e Ícones
**Story Goal**: Centralizar interações principais e exibições em widgets próprios usando herança ou Wrapper Composition (AppButton, AppInput, AppCard).
**Independent Test**: Formulários renderizam AppInputs estilizados sem repetir TextFields, Botões têm ícones semânticos, a lista exibe AppCards padronizados.

- [x] T004 [P] [US2] Implementar componente de botão primário em `lib/presentation/widgets/app_button.dart`
- [x] T005 [P] [US2] Implementar componente de input padronizado substituindo TextFormField localmente em `lib/presentation/widgets/app_input.dart`
- [x] T006 [P] [US2] Implementar card customizado visualmente atraente para itens em `lib/presentation/widgets/app_card.dart`
- [x] T007 [US2] Refatorar base do `lib/presentation/pages/paciente_form_page.dart` aplicando `AppInput` ao invés de `SharedTextField` e substituir os Actions por `AppButton`s visuais com ícones ➕ e ✏️.
- [x] T008 [US2] Refatorar base de listagem em `lib/presentation/pages/pacientes_list_page.dart` encapsulando ListTile ou equivalente num `AppCard`. Adicionar `AppButton` (flutuante ou text-based) com ícone ➕ para Add.

---

## Phase 4: US3 - Login Responsivo (Mobile & Web)
**Story Goal**: Restringir horizontalmente telas inteiras garantindo form centrados, essencial p/ experiência em desktops.
**Independent Test**: O layout no login permanece preso aos 500px quando testado em janelas amplas.

- [x] T009 [US3] Refatorar base do `lib/presentation/pages/login_page.dart` englobando inputs/submit em um Center > ConstrainedBox(maxWidth 500) e substituir os componentes primordiais base p/ `AppInput` e `AppButton` com ícone 🔐.

---

## Phase 5: Polish & Cross-Cutting Concerns
Goal: Garantir que não existam divergências de testes e garantir código 100% "clean" no visual e funcional.

- [x] T010 Rodar `flutter analyze` na raiz da aplicação
- [x] T011 Rodar `flutter test` garantindo que as modificações de apresentação não quebraram asserções (atualizar chaves Keys baseadas em TextFields nativos se os testes widget confiavam nelas)

## Implementation Strategy

1. **MVP Scope**: (US1 + Criação dos componentes US2). Isto trará toda a consistência isolada que precisamos.
2. **Execution**: Paralelizar a criação inicial base `T004`, `T005`, `T006` antes de engatilhar os formulários e listagens `T007` - `T009`. Testes em `T011` servem para retroalimentação corretiva.
