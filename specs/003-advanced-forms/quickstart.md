# Quickstart: 003-advanced-forms

## Testing the Forms

1. Run the application: `flutter run`
2. At the login screen, enter any credentials to proceed (`admin`/`123`).
3. Click "Novo Paciente" (or the floating `+` button).
4. **Form validations**:
   - Focus out or type in `E-mail` to see regex validations.
   - Type in `Telefone` to see dynamic resizing mask.
   - Type in `CPF` to see the 11-digit mask applied.
   - Form shouldn't be submitted if any field contains an error message.
5. In the `Pacientes` list:
   - Click "Excluir" (🗑️) to trigger the newly added Cancel/Confirm dialogue.
   - Test "Sair"/Logout to verify the cleanup of states.
