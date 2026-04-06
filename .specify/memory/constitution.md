<!-- 
Sync Impact Report:
- Version Change: 1.0.0 -> 2.0.0
- Modified Principles: Replaced initial rules with explicit Clean Architecture guidelines for the Patient Management System.
- Added Sections: Arquitetura Obrigatória, Regras Fundamentais, Persistência, Modelagem, Padrão de Casos de Uso, Autenticação, Padrões de UI, Reutilização, Clean Code, Diretrizes IA, O Que Não É Permitido, Escalabilidade.
- Removed Sections: Old generic Flutter principles.
- Templates Requiring Updates: ✅ plan-template.md, ✅ spec-template.md, ✅ tasks-template.md
- Follow-up TODOs: Implement initial scaffolding for Clean Architecture layers (Core, Data, Domain, Presentation).
-->
# 📜 Projeto de Gestão de Pacientes Constitution

## 🦷 Sistema de Gestão de Pacientes (Flutter + Clean Architecture)

### 1. OBJETIVO
Este projeto tem como objetivo desenvolver uma aplicação mobile em Flutter para gerenciamento de pacientes, utilizando:
- Clean Architecture
- Clean Code
- Reutilização de código
- Estrutura escalável

### 2. ARQUITETURA OBRIGATÓRIA
O projeto DEVE seguir Clean Architecture, dividido em:
- **Presentation**: Apenas UI (Widgets, Pages). Nenhuma regra de negócio.
- **Domain**: Entidades, Casos de uso, Interfaces de repositório.
- **Data**: Implementações de repositórios, Models.
- **Core**: Utilitários, Constantes, Helpers.

### 3. REGRAS FUNDAMENTAIS (NON-NEGOTIABLE)
- Nenhuma lógica de negócio na UI.
- Nenhum acesso direto ao repositório na UI.
- Toda ação deve passar por UseCases.
- Código deve ser modular e reutilizável.
- Evitar duplicação de código.

### 4. PERSISTÊNCIA (REGRA ATUAL)
- Os dados DEVEM ser armazenados em memória.
- NÃO utilizar banco de dados nesta fase.
- Preparar código para futura substituição por banco.

### 5. MODELAGEM
A entidade principal é **Paciente**:
- `id`
- `nome`
- `procedimento`
- `dataAtendimento`
- `observacoes`

### 6. PADRÃO DE CASOS DE USO
Cada operação deve ter um UseCase separado:
- `GetPacientes`
- `AddPaciente`
- `UpdatePaciente`
- `DeletePaciente`

### 7. AUTENTICAÇÃO
- Login fixo (mock).
- Sem backend.
- Sem persistência.

### 8. PADRÕES DE UI
- UI deve ser limpa e simples.
- Utilizar widgets reutilizáveis.
- Evitar código grande dentro das telas.
- Separar widgets complexos.

### 9. REUTILIZAÇÃO
Componentes reutilizáveis obrigatórios: Campos de input, Botões, Cards, Dialogs.

### 10. CLEAN CODE
- Métodos curtos.
- Nomes descritivos.
- Classes com responsabilidade única.
- Evitar arquivos grandes.

### 11. DIRETRIZES PARA GERAÇÃO COM IA
A IA deve:
- Gerar código por partes pequenas.
- Nunca gerar arquivos grandes.
- Respeitar a arquitetura definida.
- Separar corretamente camadas.
- Priorizar legibilidade.

### 12. O QUE NÃO É PERMITIDO
- Misturar camadas.
- Criar lógica dentro de Widgets.
- Acessar lista diretamente na UI.
- Ignorar UseCases.
- Código desorganizado.

### 13. ESCALABILIDADE
O sistema deve estar preparado para: Integração com banco de dados, API REST, Expansão de funcionalidades.

### 14. PRINCÍPIO FINAL
Todo código deve ser: ✔ Simples ✔ Legível ✔ Reutilizável ✔ Escalável

## Governance
This Constitution supersedes all other practices or ad-hoc conventions. Amendments require documentation and a version bump.
**Version**: 2.0.0 | **Ratified**: 2026-04-06 | **Last Amended**: 2026-04-06
