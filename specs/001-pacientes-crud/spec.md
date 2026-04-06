# Feature Specification: Pacientes CRUD

**Feature Branch**: `001-pacientes-crud`  
**Created**: 2026-04-06  
**Status**: Draft  
**Input**: User description: "Sistema de Gestão de Pacientes com autenticação simples e banco em memória falso que permite gestão via Clean Architecture"

## Clarifications

### Session 2026-04-06

- Q: State Management Solution → A: BLoC / Cubit (flutter_bloc)
- Q: Patient Entity Validation & Inputs → A: Mandatory: Nome & Procedimento. Date Picker for `dataAtendimento`.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Acesso Administrativo (Login Simples) (Priority: P1)

Como um profissional de saúde, desejo acessar o sistema usando credenciais fixas para que possa gerenciar meus pacientes de forma segura (simulada nesta fase).

**Why this priority**: É a porta de entrada da aplicação. Nenhuma funcionalidade pode ser acessada antes da autenticação.

**Independent Test**: Pode ser verificado tentando login com "admin"/"123" (deve prosseguir para a tela principal) e credenciais incorretas (deve exibir erro).

**Acceptance Scenarios**:
1. **Given** não estou autenticado e estou na tela de login, **When** insiro "admin" e "123" e clico em entrar, **Then** sou redirecionado para a tela principal sem poder voltar à tela de login.
2. **Given** não estou autenticado e estou na tela de login, **When** insiro credencial incorreta, **Then** vejo um alerta de login inválido.

---

### User Story 2 - Listagem e Visualização Rápida de Pacientes (Priority: P1)

Como um profissional, desejo visualizar uma lista de todos os meus pacientes em acompanhamento para que eu possa ter uma visão rápida dos próximos atendimentos.

**Why this priority**: A listagem reflete a capacidade da aplicação em prover informações vitais da entidade do sistema.

**Independent Test**: Acessando a tela principal, confirmar se a lista reflete os dados em tempo real a partir da camada de Data (in-memory).

**Acceptance Scenarios**:
1. **Given** estou na tela de listagem de pacientes, **When** o repositório possuir 3 pacientes carregados, **Then** vejo 3 opções listadas na tela contendo Nome e Procedimento.
2. **Given** estou na tela de listagem de pacientes, **When** a base estiver vazia, **Then** vejo uma mensagem de lista vazia ou sem cadastro recente.

---

### User Story 3 - Inclusão e Edição de Paciente (Priority: P2)

Como um profissional, desejo usar um formulário flexível para adicionar novos pacientes ou atualizar informações existentes para manter os registros sempre válidos e práticos.

**Why this priority**: É vital mutabilizar a base de dados em memória. A lista só serve perfeitamente caso existam pacientes a serem inseridos ou observações a serem atualizadas.

**Independent Test**: Criar um paciente válido e editá-lo por completo sem vazamentos entre IDs, exibindo as mudanças imediatamente.

**Acceptance Scenarios**:
1. **Given** estou na tela principal, **When** toco para adicionar um "Novo Paciente", **Then** abro o formulário com campos vazios e salvo um novo paciente que aparecerá na listagem.
2. **Given** estou na tela principal, **When** clico para editar um paciente existente, **Then** abro o formulário preenchido; e ao salvar, os dados modificados estarão refletidos na listagem.

---

### User Story 4 - Remoção com Confirmação (Priority: P3)

Como um profissional, desejo remover um paciente que não acompanharei mais com a segurança dupla de um alerta previnindo exclusões indesejadas.

**Why this priority**: Valor de limpeza de fluxo diário. Indispensável porém com menor freqüência de acionamento base.

**Independent Test**: Excluir da UI, recusar pelo Dialog, tentar novamente aceitando pelo dialog e confirmar a remoção da memória.

**Acceptance Scenarios**:
1. **Given** estou na lista de pacientes e quero apagar um deles, **When** clico na exclusão (ícone ou tela), **Then** vejo um Dialog Modal exigindo confirmação explícita.
2. **Given** vejo o dialog extra, **When** assumo exclusão, **Then** o paciente some permanentemente da lista instanciada na memória.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: O sistema MUST permitir a autenticação utilizando validação mock com o usuário `admin` e a senha `123`.
- **FR-002**: Após login positivo, o sistema MUST impossibilitar o retorno retroativo do "Navigation Stack" para a visão de login.
- **FR-003**: O sistema MUST expor a lista de pacientes simultaneamente reagente às inclusões, atualizações e demissões do banco de memória sem perdas lógicas.
- **FR-004**: O sistema MUST usar o mesmo formulário compartilhado base para a tratativa das operações de `Adição` e de `Atualização`.
- **FR-005**: Como salvaguarda para deleções acidentais, a interface MUST lançar aviso textual final do processo na forma de janela (Confirmation Dialog) solicitando clareza de remoção.

### Non-Functional / Constitution Requirements

- **NFR-001**: O projeto DEVE seguir a Clean Architecture (Presentation, Domain, Data, Core).
- **NFR-002**: NÃO PODE haver lógica de negócio ou acesso a repositório diretamente na UI. Utilize UseCases. O gerenciamento de estado (State Management) DEVE ser feito através da biblioteca `flutter_bloc` (BLoC / Cubit) interligando a camada de Presentation ao Domain.
- **NFR-003**: Os dados DEVEM ser armazenados em memória na fase atual (mock), preparado para banco no futuro.

### Key Entities *(include if feature involves data)*

- **Paciente**: Entidade básica contendo de forma explícita no projeto de Domínio: 
  - `id` (Identificador)
  - `nome` (Mandatório, String)
  - `procedimento` (Mandatório, String)
  - `dataAtendimento` (Opcional, capturado via DatePicker na UI, mantido como DateTime/String)
  - `observacoes` (Opcional, String livre).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Usuários não autenticados não podem de forma alguma manipular diretamente as vias ou burlar a barreira primária limitando fluxo estrito inicial.
- **SC-002**: Tempo de alteração visual a partir da confirmação do botão "salvar" e reflexo em listagem deve ser abaixo da percepção humana de lag ("em tempo real").
- **SC-003**: Toda comunicação externa a telas base segue estritamente a arquitetura limpa: zero invocações diretas ao banco das UI-Widgets nas validações em PR.

## Assumptions

- É aceitável que a volatilidade dos pacientes seja efêmera e o encerramento do processo zere a memória.
- Presume-se um input de credenciais validado textualmente nas variáveis e não por codificações robustas em fase de MVP temporal.
