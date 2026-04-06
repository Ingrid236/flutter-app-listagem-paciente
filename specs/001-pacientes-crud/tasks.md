# Implementation Tasks: Pacientes CRUD

**Feature**: 001-pacientes-crud
**Status**: Generated

## 1. Setup Phase

- [x] T001 Adicionar dependências (`flutter_bloc`, `equatable`, `intl`, `mocktail` para testes) no `lib/pubspec.yaml` (ou na raiz do repositório)
- [x] T002 Criar estrutura de diretórios base para Clean Architecture (core, data, domain, presentation)

## 2. Foundational Phase

- [x] T003 Implementar abstrações base Core (e.g. `UseCase`, `Failure`) em `lib/core/usecases/usecase.dart` e `lib/core/errors/failures.dart`
- [x] T004 Configurar arquivo main e injeção de dependência básica em `lib/main.dart`

## 3. User Story Phases

### [US1] Acesso Administrativo (Login Simples)

**Goal**: Permitir que admin acesse o sistema através de credenciais fixas ("admin" / "123").
**Test Criteria**: Bloqueia logins errados e redireciona (sem volta) em login correto.

- [x] T005 [P] [US1] Criar teste unitário para o UseCase de Login em `test/domain/usecases/login_user_test.dart`
- [x] T006 [P] [US1] Implementar UseCase Mock de Login em `lib/domain/usecases/login_user.dart`
- [x] T007 [US1] Criar testes do AuthBloc/Cubit em `test/presentation/bloc/auth_cubit_test.dart`
- [x] T008 [US1] Implementar `AuthCubit` e seus estados em `lib/presentation/bloc/auth/auth_cubit.dart`
- [x] T009 [US1] Criar a UI de Login contendo inputs em `lib/presentation/pages/login_page.dart`
- [x] T010 [US1] Atualizar `main.dart` e rotas para carregar a `login_page.dart` como rota inicial

### [US2] Listagem e Visualização Rápida de Pacientes

**Goal**: Listar todos os pacientes cadastrados utilizando dados em memória contendo Nome e Procedimento.
**Test Criteria**: Reflete alterações do runtime memory na tela principal. Lista vazia mostra mensagem apropriada.

- [x] T011 [P] [US2] Criar a Entidade de Domínio `Paciente` em `lib/domain/entities/paciente.dart`
- [x] T012 [P] [US2] Criar os testes p/ `PacienteModel` em `test/data/models/paciente_model_test.dart`
- [x] T013 [P] [US2] Criar o Data Mapper abstrativo `PacienteModel` em `lib/data/models/paciente_model.dart`
- [x] T014 [US2] Definir contrato do repositório de domínio em `lib/domain/repositories/paciente_repository.dart`
- [x] T015 [US2] Escrever testes unitários e implementar o repositório em memória em `lib/data/repositories/paciente_repository_memory_impl.dart`
- [x] T016 [US2] Criar testes de UseCase e Implementar `GetPacientes` em `lib/domain/usecases/get_pacientes.dart`
- [x] T017 [US2] TDD + Implementação do `PacienteCubit` gerenciando Loading, Success, Error em `lib/presentation/bloc/paciente/paciente_cubit.dart`
- [x] T018 [US2] Criar a UI de Listagem (Widget principal da aplicação) em `lib/presentation/pages/pacientes_list_page.dart` e conectá-la ao BlocBuilder

### [US3] Inclusão e Edição de Paciente

**Goal**: Formulário compartilhado com data picker e inputs de dados para salvar/editar pacientes.
**Test Criteria**: Cria e atualiza sem vazar ID; exibe as inclusões em Listagem.

- [x] T019 [P] [US3] Criar testes e UseCase de inserção (`AddPaciente`) em `lib/domain/usecases/add_paciente.dart`
- [x] T020 [P] [US3] Criar testes e UseCase de atualização (`UpdatePaciente`) em `lib/domain/usecases/update_paciente.dart`
- [x] T021 [US3] Injetar invocações de Create/Update no `PacienteCubit` (ex: `lib/presentation/bloc/paciente/paciente_cubit.dart`)
- [x] T022 [US3] Implementar Widget reutilizável de Input em `lib/presentation/widgets/shared_text_field.dart`
- [x] T023 [US3] Criar Interface do Formulário flexível c/ DatePicker em `lib/presentation/pages/paciente_form_page.dart`
- [x] T024 [US3] Vincular Actions/Navigations na `pacientes_list_page.dart` acionando a tela de form para criação ou edição.

### [US4] Remoção com Confirmação

**Goal**: Exclusão condicional da runtime DB providenciada com Dialog de confirmação duplo.
**Test Criteria**: Interação e aprovação explícita remove registro com precisão.

- [x] T025 [P] [US4] Criar testes e UseCase de exclusão (`DeletePaciente`) em `lib/domain/usecases/delete_paciente.dart`
- [x] T026 [US4] Injetar o UseCase de Delete no `PacienteCubit`
- [x] T027 [US4] Criar alerta de confirmação em `lib/presentation/widgets/shared_confirmation_dialog.dart`
- [x] T028 [US4] Implementar `Dismissible` com swipe-to-delete e acionamento do ConfirmDialog na interface de Listagem.

## 4. Final Phase: Polish & Cross-Cutting

- [x] T029 Padrões estáticos: Revisar com `flutter format lib test` e zerar lints (`flutter analyze`).

## Dependencies

- Setup Phase `<-` Foundational Phase
- Foundational Phase `<-` US1 (Login independente)
- Foundational Phase `<-` US2 (Listagem base do CRUD)
- US2 `<-` US3 (Formulário precisa ver e recarregar a lista)
- US2 `<-` US4 (Exclusão demanda interface da lista carregada previamente)

## Parallel Execution Mapping

Devido a desvinculação em Clean Architecture e uso estrito de DDD, existem os seguintes pontos de implementação paralela `[P]`:
- T005/T006 (UseCase Login) podem ser feitos de forma autônoma em relação ao bloco de UI (T009).
- Enquanto um dev executa a Entidade e Modelagem (T011, T012, T013), outro pode ir escrevendo UseCases de CRUD (T019, T020, T025).

## Implementation Strategy

1. **MVP First**: Entregar primeiramente US1 e US2. Elas constroem inteiramente a navegação estrita e viabilizam o teste da arquitetura (Repository/Domain). 
2. **Incremental CRUD**: As Histórias 3 e 4 tornam-se incrivelmente eficientes com a arquitetura solidificada pois dependem prioritariamente da elaboração de novos widgets Presentation, reutilizando os padrões já erguidos pelo MVP base.
