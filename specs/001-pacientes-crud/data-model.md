# Data Model: Pacientes CRUD

## Entities

### `Paciente` (Domain Entity)
Objeto central da aplicação contendo as regras de dados independentes da UI ou Banco de Dados.

#### Fields
- `id`: `String` (UUID ou Identifier único).
- `nome`: `String` (Obrigatório, min de caracteres).
- `procedimento`: `String` (Obrigatório).
- `dataAtendimento`: `DateTime?` (Opcional, preenchido via interface de calendário UI).
- `observacoes`: `String?` (Opcional).

### `PacienteModel` (Data Layer Mapper)
Classe estendendo intersecamente das características do Paciente para conversões ou simulações futuras. Sendo na atualidade muito parelho à Entity mas existindo para não sujar a Domain de serializações.

#### Methods
- `fromJson(Map<String, dynamic> json)`
- `toJson() -> Map<String, dynamic>`

## Transitions

- O aplicativo iniciará com a memória contendo List<PacienteModel> vazia.
- Não existem transições complexas de deleção suave (soft delete). Uma vez invocada a deleção, a entidade Paciente some do runtime.
