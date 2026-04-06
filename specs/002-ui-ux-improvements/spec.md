# Feature Specification: Melhoria de UI/UX para CRUD de Pacientes

**Feature Branch**: `002-ui-ux-improvements`  
**Created**: 2026-04-06  
**Status**: Draft  
**Input**: User description: "Plano de melhoria de UI/UX para o CRUD de Pacientes. Padronização de botões, inputs, tipografia e estrutura visual geral sem alterar regras de negócio"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Padronização do Tema Global (Priority: P1)

Como usuário, desejo visualizar uma base visual mais atraente e limpa com esquema de cor azul predominante (Light mode) e tipografia distinta para títulos e textos, para que a marca pareça profissional e coesa.

**Why this priority**: Estabelece o padrão mestre para todos os componentes. Sem ele, os componentes seriam estilizados manualmente, prejudicando a manutenção.

**Independent Test**: Pode ser validado através da inicialização do AppBar e contrastes de textos nativos logo ao iniciar o Scaffold base.

**Acceptance Scenarios**:

1. **Given** que o aplicativo é inicializado no modo claro, **When** qualquer tela é exibida, **Then** as cores primárias em todos os elementos devem apresentar a paleta azul e refletir a hierarquia de fontes configurada.
2. **Given** que o aplicativo roda num simulador Flutter, **When** o mesmo é executado, **Then** não haverá barra amarela com texto "DEBUG".

---

### User Story 2 - Componentes Universais e Ícones (Priority: P2)

Como usuário, espero ver botões unificados com ícones padronizados para representar ações (➕ Adicionar paciente, ✏️ Editar, 🗑️ Excluir, 🔐 Login) e campos de texto claros com bordas consistentes e inputs previsíveis (`AppButton`, `AppInput`, `AppCard`).

**Why this priority**: Uniformiza os componentes da interface. Garantir isso impede que o mesmo componente em telas diferentes tenha formas diferentes.

**Independent Test**: Telas onde houver listagem ou formulários atuarão explicitamente invocando a classe `AppInput` ou `AppButton` em vez dos equivalentes Material originais.

**Acceptance Scenarios**:

1. **Given** a tela de listagem de pacientes, **When** os pacientes são renderizados, **Then** todos devem estar encapsulados numa estrutura simétrica `AppCard` com sombreado leve.
2. **Given** a elaboração do formulário, **When** visualizando ações, **Then** todo botão possuirá ícones correspondentes à semântica da ação.

---

### User Story 3 - Login Responsivo (Mobile & Web) (Priority: P3)

Como usuário operando em dispositivos de tela maior, espero que a tela de login respeite meus limites periféricos e seja centralizada em um container limpo de até 500px, em vez de se esticar infinitamente na tela toda. 

**Why this priority**: Uma UX básica que previne layout deformado em desktops e prepara o app para a web de forma profissional.

**Independent Test**: Acessando a tela de Login no navegador (web renderer).

**Acceptance Scenarios**:

1. **Given** que o usuário está no computador/tablet nativo, **When** avança à página inicial (login), **Then** percebe um espaçamento lateral, sombreamento de container e dimensões fixadas no centro em vez de toda a janela.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: O Sistema DEVE instanciar um `ThemeData` contendo paleta base focada no azul (Primário, Secundário, Destaque).
- **FR-002**: O Sistema DEVE incorporar e substituir as chamadas para `AppButton`, `AppCard` e `AppInput` como peças visuais reutilizáveis em vez dos equivalentes padrões com estilo ad-hoc.
- **FR-003**: O Sistema DEVE alocar regras de tipografia onde títulos apresentam variação visual distinto e superior contra subtítulos e texto base.
- **FR-004**: O Sistema DEVE centralizar o Login verticalmente e horizontalmente com limitação arbitrária (máx. 500px) para resoluções web.
- **FR-005**: O Sistema DEVE inativar dinamicamente o debug banner (`debugShowCheckedModeBanner: false`).
- **FR-006**: Todos os botões do Sistema (salvar, logar, excluir, editar, adicionar) DEVEM possuir um ícone representativo.

### Non-Functional / Constitution Requirements

- **NFR-001**: A integração visual NÃO DEVE vazar dependência nem alterar nenhuma lógica de `UseCase`, repositórios ou estado estrutural sob `flutter_bloc`. Trata-se puramente da camada de **Presentation**.
- **NFR-002**: A interface DEVE adotar modelagem Responsiva/Mobile-first (evitando quebra visual entre Web e Mobile).
- **NFR-003**: ZERO quebra nas métricas e regras da constituição original Clean Architecture definida para este projeto.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: O Flutter Analyzer exibe `0` conflitos após aplicar as bibliotecas extraídas de UI (mantendo a cobertura e testes TDD intocados, sem causar loops/erros de execução paralela).
- **SC-002**: Inspeção do código valida o uso do Component Pattern: 100% dos formulários usam `AppInput` em vez de `TextFormField` direto.
- **SC-003**: Layout de login reflete Max-Width para web (confirmável reduzindo e expandindo o simulador de tela).
- **SC-004**: Inspeciona `MaterialApp` indicando explicitamente `debugShowCheckedModeBanner: false`.

## Assumptions

- Presume-se a continuidade do Flutter Material 3 como backbone.
- Escopo adere unicamente a `Light Mode` primário embora estruture o código com previsões semânticas suficientes para receber o tema escuro isolado futuramente.
- Paleta Azul baseada em sugestões harmônicas (ex: Teal Blue/Sky) conforme falta de HEX exato provido. Estarei definindo o azul harmônico conforme boas práticas materiais.
