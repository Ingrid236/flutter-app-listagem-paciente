<!--
Sync Impact Report:
- Version Change: 2.0.0 → 2.1.0 (MINOR: novos princípios adicionados — Git Workflow,
  Design System, Validação de Formulários e Higiene de Código)
- Modified Principles:
    - §5 MODELAGEM: campos da entidade Paciente atualizados para refletir estado real
    - §8 PADRÕES DE UI: expandido com regras de Design System e reutilização de componentes
    - §10 CLEAN CODE: expandido com regras de naming, arquivo e widget size
    - §12 O QUE NÃO É PERMITIDO: expandido com proibições específicas detectadas na análise
- Added Sections:
    - §15 FLUXO DE BRANCHES NO GIT (novo — obrigatório)
    - §16 DESIGN SYSTEM E COMPONENTES (novo — derivado da análise de código)
    - §17 VALIDAÇÃO DE FORMULÁRIOS (novo — derivado do escopo 003-advanced-forms)
    - §18 HIGIENE DE CÓDIGO (novo — derivado da análise de dívida técnica)
- Removed Sections: nenhuma
- Templates Requiring Updates:
    - ✅ plan-template.md — Constitution Check atualizado (ver abaixo)
    - ✅ spec-template.md — NFR atualizado (ver abaixo)
    - ✅ tasks-template.md — Anotação de branch + Phase 0 atualizado (ver abaixo)
- Follow-up TODOs:
    - TODO(GIT_REMOTE_URL): confirmar URL do repositório remoto no GitHub
    - TODO(BRANCH_PROTECTION): habilitar branch protection rules em `main` no GitHub
    - TODO(PACIENTE_MODEL_SYNC): sincronizar PacienteModel com campos novos da entidade
-->

# 📜 Projeto de Gestão de Pacientes — Constituição

## 🦷 Sistema de Gestão de Pacientes (Flutter + Clean Architecture)

---

### 1. OBJETIVO

Este projeto tem como objetivo desenvolver uma aplicação mobile em Flutter para
gerenciamento de pacientes, utilizando:

- Clean Architecture
- Clean Code
- Design System consistente
- Reutilização de código
- Estrutura escalável e preparada para evolução

---

### 2. ARQUITETURA OBRIGATÓRIA

O projeto DEVE seguir Clean Architecture, dividido em quatro camadas:

| Camada         | Responsabilidade                                              |
|----------------|---------------------------------------------------------------|
| `Presentation` | Apenas UI (Widgets, Pages, BLoC/Cubit). Sem regras de negócio.|
| `Domain`       | Entidades, Casos de uso, Interfaces de repositório.           |
| `Data`         | Implementações de repositórios, Models (DTO).                |
| `Core`         | Utilitários, Constantes, Tema, Validators, Formatters.       |

Cada camada DEVE estar em seu próprio diretório dentro de `lib/`.

---

### 3. REGRAS FUNDAMENTAIS (NON-NEGOTIABLE)

- Nenhuma lógica de negócio DEVE existir na camada de UI.
- Nenhum acesso direto a repositório DEVE ocorrer na UI.
- Toda ação de negócio DEVE passar por um UseCase correspondente.
- Código DEVE ser modular e reutilizável.
- Duplicação de código NÃO É PERMITIDA — extrair para componente/helper.
- Archivos com mais de 200 linhas DEVEM ser refatorados e divididos.

---

### 4. PERSISTÊNCIA (REGRA ATUAL)

- Os dados DEVEM ser armazenados em memória via repositório in-memory.
- NÃO utilizar banco de dados real nesta fase.
- O código DEVE ser preparado para substituição futura por banco de dados:
  abstrações de repositório NO domínio, implementações concretas NA camada data.

---

### 5. MODELAGEM

A entidade principal é **Paciente** com os seguintes campos obrigatórios/opcionais:

| Campo             | Tipo        | Obrigatoriedade |
|-------------------|-------------|-----------------|
| `id`              | `String`    | Obrigatório     |
| `nome`            | `String`    | Obrigatório     |
| `procedimento`    | `String`    | Obrigatório     |
| `telefone`        | `String?`   | Opcional        |
| `cpf`             | `String?`   | Opcional        |
| `email`           | `String?`   | Opcional        |
| `tipo`            | `String?`   | Opcional        |
| `dataAtendimento` | `DateTime?` | Opcional        |
| `observacoes`     | `String?`   | Opcional        |

> **IMPORTANTE**: O `PacienteModel` (camada Data) DEVE sempre refletir todos os
> campos da entidade `Paciente` (camada Domain). Qualquer campo adicionado à
> entidade DEVE ser imediatamente adicionado ao Model e ao repositório.

---

### 6. PADRÃO DE CASOS DE USO

Cada operação DEVE ter um UseCase separado em `lib/domain/usecases/`:

- `GetPacientes`
- `AddPaciente`
- `UpdatePaciente`
- `DeletePaciente`

Novos casos de uso DEVEM seguir o contrato `UseCase<ReturnType, Params>` definido
em `lib/core/usecases/usecase.dart`.

---

### 7. AUTENTICAÇÃO

- Login DEVE ser fixo (mock) utilizando `LoginUser` UseCase.
- Sem backend real ou integração OAuth nesta fase.
- Sem persistência de sessão entre reinicializações.
- Credenciais hardcoded DEVEM ser marcadas com comentário `// TODO: Substituir
  por autenticação real antes de deploy em produção`.

---

### 8. PADRÕES DE UI

- UI DEVE usar os componentes do **Design System** (`AppFormField`, `AppButton`,
  `AppSpacing`, `AppCard`) em vez de widgets Flutter primitivos diretamente.
- Widgets reutilizáveis DEVEM ser extraídos para `lib/presentation/widgets/`.
- Pages DEVEM ser de coordenação apenas (conectar BLoC ↔ widgets).
- Cores DEVEM ser referenciadas via `AppColors` — `Colors.*` hardcoded é proibido.
- Espaçamentos DEVEM ser referenciados via `AppSpacing`.
- Widgets legados substituídos por componentes novos DEVEM ser removidos do projeto.

---

### 9. REUTILIZAÇÃO

Componentes reutilizáveis obrigatórios — DEVEM existir e ser usados:

| Componente                   | Localização                              |
|------------------------------|------------------------------------------|
| `AppFormField`               | `lib/presentation/widgets/`             |
| `AppButton`                  | `lib/presentation/widgets/`             |
| `AppCard`                    | `lib/presentation/widgets/`             |
| `AppSpacing`                 | `lib/presentation/widgets/`             |
| `SharedConfirmationDialog`   | `lib/presentation/widgets/`             |
| `AppColors`                  | `lib/core/theme/colors.dart`            |
| `AppTheme`                   | `lib/core/theme/app_theme.dart`         |
| `FormValidators`             | `lib/core/validators/`                  |
| `AppMasks`                   | `lib/core/formatters/`                  |

Componentes não utilizados DEVEM ser removidos — dead code NÃO É TOLERADO.

---

### 10. CLEAN CODE

- Métodos DEVEM ser curtos (máximo 30 linhas como diretriz).
- Nomes DEVEM ser descritivos e em inglês (exceto termos de domínio em português
  ex: `paciente`, `procedimento`).
- Classes DEVEM ter responsabilidade única (SRP).
- Geração de IDs DEVE ocorrer na camada Data/Domain — nunca na Presentation.
- `ServiceLocator` DEVE residir em `lib/core/di/service_locator.dart`.
- Métodos declarados mas não utilizados DEVEM ser removidos.
- Propriedades de estado declaradas mas não consumidas na UI DEVEM ser utilizadas
  ou removidas.

---

### 11. DIRETRIZES PARA GERAÇÃO COM IA

A IA DEVE:

- Gerar código por partes pequenas e incrementais.
- Nunca gerar arquivos com mais de 200 linhas sem refatoração explícita.
- Respeitar a arquitetura e as camadas definidas.
- Priorizar legibilidade e nomenclatura consistente.
- Após cada geração, verificar se algum arquivo tornou-se obsoleto e marcá-lo
  para remoção.
- Executar `flutter analyze` e verificar que não há erros antes de encerrar
  qualquer tarefa.

---

### 12. O QUE NÃO É PERMITIDO

- Misturar camadas de arquitetura.
- Criar lógica de negócio dentro de Widgets ou Pages.
- Acessar repositórios diretamente na UI.
- Ignorar UseCases para operações de negócio.
- Usar `Colors.*` diretamente — DEVE ser `AppColors.*`.
- Usar `const EdgeInsets.all(N)` avulso — DEVE ser `AppSpacing.*`.
- Manter widgets legados obsoletos junto aos novos.
- Commitar código diretamente na branch `main` ou `master`.
- Abrir Pull Request sem ter rodado `flutter analyze` e `flutter test`.
- Manter código morto (dead code) — métodos, classes e imports não utilizados.
- Iniciar trabalho de código sem criar uma branch dedicada no GitHub.

---

### 13. ESCALABILIDADE

O sistema DEVE estar preparado para futuras evoluções:

- Integração com banco de dados (Hive, SQLite, Firebase).
- Integração com API REST.
- Expansão de funcionalidades sem reescrever a arquitetura base.

---

### 14. PRINCÍPIO FINAL

Todo código gerado DEVE ser:
✔ **Simples** — menor complexidade que resolve o problema
✔ **Legível** — autoexplicativo sem excesso de comentários
✔ **Reutilizável** — componentes extraídos e genéricos
✔ **Escalável** — preparado para crescer sem reescrever
✔ **Limpo** — sem dead code, sem imports não usados

---

### 15. FLUXO DE BRANCHES NO GIT (OBRIGATÓRIO)

**Nenhuma alteração de código PODE ser feita diretamente na branch `main`.**

#### 15.1 Regra Absoluta

Antes de iniciar QUALQUER modificação no código — seja uma nova feature, bugfix,
refatoração ou atualização de documentação técnica — uma branch DEVE ser criada.

#### 15.2 Convenção de Nomenclatura

```
<tipo>/<###-descricao-curta>
```

| Tipo        | Quando usar                                          | Exemplo                              |
|-------------|------------------------------------------------------|--------------------------------------|
| `feature/`  | Nova funcionalidade                                  | `feature/004-logout-button`          |
| `fix/`      | Correção de bug                                      | `fix/003-cpf-mask-validation`        |
| `refactor/` | Refatoração sem mudança de comportamento             | `refactor/cleanup-legacy-widgets`    |
| `chore/`    | Atualização de dependências, configuração, docs      | `chore/update-pubspec-dependencies`  |
| `test/`     | Adição ou correção de testes                         | `test/paciente-form-cubit-coverage`  |

#### 15.3 Fluxo Completo Obrigatório

```
1. Criar branch:   git checkout -b feature/###-nome-da-feature
2. Desenvolver:    [implementar as mudanças]
3. Testar local:   flutter analyze && flutter test
4. Commitar:       git commit -m "tipo: descrição clara do que foi feito"
5. Push:           git push origin feature/###-nome-da-feature
6. Pull Request:   Abrir PR no GitHub apontando para main
7. Review/Merge:   Aprovar e fazer merge via GitHub (squash ou merge commit)
8. Limpar:         git branch -d feature/###-nome-da-feature
```

#### 15.4 Commits

Mensagens de commit DEVEM seguir o padrão Conventional Commits:

```
<tipo>(<escopo opcional>): <descrição em português ou inglês>

Exemplos:
feat(form): adiciona máscara de CPF ao formulário de paciente
fix(validators): corrige validação de e-mail com caracteres especiais
refactor(widgets): remove AppInput e SharedTextField legados
chore(deps): atualiza mask_text_input_formatter para 2.0
test(cubit): adiciona testes unitários para PacienteFormCubit
```

#### 15.5 Gates de Pull Request

Um PR NÃO PODE ser mergeado sem:

- [ ] `flutter analyze` sem erros
- [ ] `flutter test` passando (todos os testes verdes)
- [ ] Revisão de aderência à constituição (arquitetura, design system, dead code)

---

### 16. DESIGN SYSTEM E COMPONENTES

#### 16.1 Hierarquia de Tokens

```
AppColors     → valores de cor (primário, erro, fundo, texto)
AppSpacing    → valores de espaçamento (xs, sm, md, lg, xl)
AppTheme      → configuração global do MaterialApp
```

#### 16.2 Regras de Uso

- Toda cor referenciada em widget DEVE vir de `AppColors` ou do `ColorScheme`
  do tema (`Theme.of(context).colorScheme.*`).
- Todo espaçamento fixo DEVE usar `AppSpacing.verticalMd` (widget) ou
  `AppSpacing.md` (double).
- `OutlineInputBorder` e `InputDecoration` DEVEM ser configurados pelo tema global
  em `AppTheme` — não redefinidos individualmente em cada campo.

#### 16.3 Ciclo de Vida de Componentes

- Componente entra em uso: documentar em §9 desta constituição.
- Componente é substituído: arquivo original DEVE ser deletado na mesma PR que
  introduz o substituto.
- Componente é depreciado provisoriamente: adicionar `@Deprecated` annotation antes
  da remoção na PR seguinte.

---

### 17. VALIDAÇÃO DE FORMULÁRIOS

- Todo formulário DEVE usar `GlobalKey<FormState>` e `Form` widget.
- Cada campo DEVE ter seu `TextEditingController` gerenciado pelo Cubit/BLoC
  correspondente (NÃO no `State` do `StatefulWidget`) para garantir `dispose()`
  correto.
- Validações DEVEM usar os métodos centralizados de `FormValidators`.
- Máscaras de input DEVEM usar formatters de `AppMasks`.
- Formatters e validadores declarados mas não utilizados DEVEM ser removidos ou
  implementados.
- O estado `isFormValid` exposto pelo Cubit DEVE ser consumido pela UI para
  habilitar/desabilitar o botão de submissão.

---

### 18. HIGIENE DE CÓDIGO

A cada Pull Request, o autor DEVE verificar:

- [ ] Nenhum import não utilizado.
- [ ] Nenhuma variável ou método declarado e não chamado.
- [ ] Nenhum componente legado ainda presente se já substituído.
- [ ] `PacienteModel` sincronizado com todos os campos de `Paciente`.
- [ ] `ServiceLocator` em `lib/core/di/service_locator.dart` (não em `main.dart`).
- [ ] Cores e espaçamentos usando tokens do Design System.
- [ ] Nenhum `TODO` de placeholder esquecido no código.

---

## Governance

Esta Constituição substitui todas as práticas anteriores ou convenções ad-hoc.

Qualquer emenda REQUER:
1. Proposta documentada (pode ser um comentário no PR).
2. Bump de versão seguindo SemVer.
3. Atualização do `LAST_AMENDED_DATE`.
4. Propagação para templates dependentes (plan, spec, tasks).

**Version**: 2.1.0
**Ratified**: 2026-04-06
**Last Amended**: 2026-04-06
