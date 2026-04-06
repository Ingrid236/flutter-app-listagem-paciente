# Feature Specification: UI/UX Advanced Plan + Forms Management

**Feature Branch**: `003-advanced-forms`  
**Created**: 2026-04-06  
**Status**: Draft  

## User Scenarios & Testing *(mandatory)*

### User Story 1 - SPEC 2: AppFormField (input reutilizável) (Priority: P1)

Como desenvolvedor, eu preciso de um componente visual reutilizável de input (`AppFormField`) para que eu não precise duplicar lógica visual, de ícones e comportamentos base de texto.

**Why this priority**: É a base visual de todos os formulários e logins, precisa estar pronta antes das telas.

**Independent Test**: Can be tested via visual widget gallery. O componente renderiza corretamente a tipografia, a cor de borda, padding interno e pode opcionalmente receber ícones e validadores.

**Acceptance Scenarios**:
1. **Given** um formulário instanciando `AppFormField` com ícone, **When** ele é renderizado, **Then** o ícone especificado aparece à esquerda do input e exibe hints visuais apropriados.
2. **Given** o mesmo componente validando, **When** um erro ocorrer, **Then** as bordas refletem o estado de erro e exibem uma string descritiva sob o campo.

---

### User Story 2 - SPEC 3: AppButton (Priority: P1)

Como desenvolvedor, preciso de um componente de botão padronizado com feedback de clique usando InkWell, mantendo padronização nas telas de login, formulários e listagens.

**Why this priority**: Componente atômico universal ao lado de AppFormField.

**Independent Test**: Instanciar na tela, testar clique visual (splash no on-tap), desativar passando onPressed null.

**Acceptance Scenarios**:
1. **Given** o botão na tela instanciado com uma ação, **When** o usuário clica nele, **Then** a animação de splash ocorre e o callback `onTap` é invocado.

---

### User Story 3 - SPEC 4: Provider de Formulário (Priority: P2)

Como usuário, eu quero que as validações e preenchimento não dependam da interface renderizá-las diretamente, mas passem por uma camada de provider para isolar a tela da reatividade de dados e não vazar memória.

**Why this priority**: O provider precisa abstrair a estrutura reativa dos dados, garantindo uso adequado do SRP e servindo aos formulários avançados futuros.

**Independent Test**: Pode ser verificado disparando mudanças dentro de um widget test verificando o estado atualizado do Provider.

**Acceptance Scenarios**:
1. **Given** um `FormProvider` que armazena os estados dos `Controllers`, **When** instanciado e os campos recebem input, **Then** a UI se recompõe apenas no ponto necessário ouvindo os getters do Provider.
2. **Given** o ciclo de vida da tela sendo fechada (dispose), **When** a tela some, **Then** os controllers atrelados ao Provider devem ser dispostos para evitar vazamento (memory leak).

---

### User Story 4 - SPEC 1: Formulário de Paciente com Validação Completa (Priority: P2)

Como recepcionista do consultório, eu preciso de um formulário de paciente que tenha validações restritas (RG/CPF, Data, Nome e Telefone com máscaras) garantindo dados de qualidade para a gestão da clínica, validando obrigações de negócio.

**Why this priority**: Fim a fim do fluxo de cadastro com dados reais robustos.

**Independent Test**: Tentar enviar o formulário sem preencher os campos retorna múltiplos erros simultâneos.

**Acceptance Scenarios**:
1. **Given** o formulário no cadastro do paciente, **When** o usuário digita no campo de CPF, **Then** a máscara "000.000.000-00" é preenchida ativamente em tempo-real.
2. **Given** o final do preenchimento, **When** clica em Salvar, **Then** se houver e-mail inválido, aparece "E-mail inválido"; se houver sucesso o Provider salva.

---

### User Story 5 - SPEC 5: Refatoração da tela de Login (Priority: P3)

Como usuário, desejo acessar uma tela de login moderna com visual restrito em Desktop, sombra baseada no IHC, limitando a expansão estranha que acontece atualmente via browser.

**Why this priority**: O acesso é a entrada da clínica. Deve ser uma tela premium.

**Independent Test**: Testar em resize vertical do browser e no modo responsivo garantindo não exceder 500px, centralizando um card.

**Acceptance Scenarios**:
1. **Given** um desktop 1920x1080p acessando Login, **When** a página carrega, **Then** o formulário flutua centralizado limitado a max 500px na largura total.

---

### User Story 6 - SPEC 6: Lista de Pacientes com Componentes Separados (Priority: P3)

Como recepcionista, quero listar pacientes contendo informações diretas usando AppSpacing sem magia de "SizedBox", visualizar de forma coerente a lista visual e os botões "Editar" ✏️ e "Excluir" 🗑️, incluindo confirmação prévia no último. No topo preciso ver um botão global de Logout e o título do escopo do consultório da odonto.

**Why this priority**: É onde o utilizador ficará a maior parte do tempo.

**Independent Test**: Listar e excluir passando pela janela interativa de cancelamento de exclusão antes de consumar o ato.

**Acceptance Scenarios**:
1. **Given** pacients cadastrados, **When** clicar em [🗑️ Excluir], **Then** o provider/sistema abre a confirmação "Confirmar exclusão?", prevenindo erro humano.

---

### Edge Cases

- O que acontece se o usuário submeter muito rapidamente cliques seguidos no Login? O estado do Provider deve inibir envios duplicados enquanto estiver em modo `loading`.
- O que acontece se o formulário for minimizado ou descartado? Os `TextEditingController` não devem ficar retidos no provider vazando contexto global. Devem ser descartados no encerramento (dispose).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: O sistema MUST formatar CPF com máscara ativamente à medida que o texto é composto com suporte na formatação brasileira padrão e os 2 dígitos verificadores validados.
- **FR-002**: O sistema MUST formatar e mascarar Telefones `(99) 9999-9999` e celulares `(99) 99999-9999`.
- **FR-003**: O sistema MUST expor validadores para E-mail robusto usando Regex nativo.
- **FR-004**: O sistema MUST limitar os nomes de pacientes a no máximo 150 caracteres.
- **FR-005**: O formulário do paciente MUST possuir o campo obrigatório `Tipo` restrito à dropdown contendo área odontológica: `Endodontia, Ortodontia, Periodontia`.
- **FR-006**: O aplicativo MUST exibir o nome "Sistema de Gestão de Pacientes Odontológicos" na página principal de Listagem juntamente com a ação de Logout.
- **FR-007**: A Listagem MUST exibir botão "Excluir" pedindo confirmação expressa antes de apagar a linha da UI.
- **FR-008**: O sistema MUST prover componentes estruturais semânticos para o sistema de design: `AppFormField` (Inputs), `AppButton` (botões), `AppSpacing` (enum thin/mid/large para evitar constantes mágicas codificadas na view).

### Non-Functional / Constitution Requirements

- **NFR-001**: O projeto DEVE seguir a Clean Architecture (Presentation, Domain, Data, Core).
- **NFR-002**: A lógica de regra de aplicação, estado do form e controllers de texto, DEVEM estar abstraídos inteiramente dentro de Providers (ex: `FormProvider`), deixando a `Page` Widget responsável apenas e inteiramente pela exposição visual, fortalecendo o Single Responsibility Principle (SRP).
- **NFR-003**: Garantir que as diretrizes IHC (Visibility, Mapping, Freedom, Consistency e Error Prevention) sejam atendidas em todos os fluxos. Toda página que envolve deleção e formulário tem de ter confirmação e labels claros na tela visíveis de antemão. Sem uso de IDs obscuros em logs de error de ecrã para os recepcionistas.

### Key Entities

- **Paciente**: Comporta os novos atributos descritos entre os inputs (`tipo: Dropdown` a ser expandido à entidade, ou adaptado à variável `procedimento`).
- **UserSession (Auth)**: Utilizada estritamente para o botão de "Logout".

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: As entidades de visualização no Formulário diminuirão em termos de LOC (lines of code), delegando o tamanho à estrutura `AppFormField`, aumentando legibilidade 100% sobre as views de tela.
- **SC-002**: 100% dos formulários interativos devem possuir máscaras para Telefone e CPF/CNPJ, e validação RegEx para E-mail de modo passsivo e visual, informando no `AppFormField` sobre erros na string ao salvar ou perder foco.
- **SC-003**: 0% de ocorrência de `memory leak` no Flutter DevTools proveniente de falhas de `TextEditingController` não descartado em fechamentos de tela por gestão equivocada.

## Assumptions

- Presume-se que o provider gerenciador de estado nativo (`flutter_bloc` nativo ou `provider` nativo) seja usado em conformidade. O app atualmente usa `flutter_bloc`, o requisito diz `Provider`. Assumimos que o estado do form pode usar `ChangeNotifierProvider` isolado ou adaptar a um state manager já incluso.
- Presume-se que RegEx de e-mail e regras de verificação de CPF não requerem internet.
- A máscara do telefone aceitará formatos de tamanho dinâmico (8 ou 9 dígitos no final).
