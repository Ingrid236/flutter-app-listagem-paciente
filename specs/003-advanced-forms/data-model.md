# Data Model: Advanced Forms

## Entities

### `Paciente`
The core entity managed by the forms.
**Fields:**
- `id` (String): Unique identifier.
- `nome` (String): Name of the patient (Max 150 chars, handled in UI).
- `procedimento` (String): Temporary mapped or mapped to UI details.
- `telefone` (String): Added for new forms (Mask '(99) 99999-9999').
- `cpf` (String): Added for new forms (Mask '000.000.000-00').
- `email` (String): Added for new forms (Regex validated).
- `tipo` (Enum/String): Dropdown selection (`Endodontia`, `Ortodontia`, `Periodontia`).
- `dataAtendimento` (DateTime): Associated appointment date.
- `observacoes` (String): Optional notes.

### Form State (`PacienteFormState`)
- `status`: Idle, Loading, Success, Error
- `isValid`: Boolean
- `errors`: Map<String, String> (maps field keys to localized error strings)

## Validation Rules
1. **CPF**: Exactly 11 numbers under the mask, plus verifying algorithm check.
2. **Telefone**: 10 or 11 numeric digits under the mask.
3. **E-mail**: Must match `r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"`
4. **Nome**: Non-empty, max 150.
5. **Tipo**: Cannot be null.
