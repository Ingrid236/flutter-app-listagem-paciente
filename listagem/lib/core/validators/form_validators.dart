class FormValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-mail é obrigatório';
    }
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  static String? validateCPF(String? value) {
    if (value == null || value.isEmpty) {
      return 'CPF é obrigatório';
    }
    final cleanCPF = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanCPF.length != 11) {
      return 'CPF deve ter 11 dígitos';
    }
    
    // Simplificado para o exemplo, mas segue a estrutura solicitada.
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefone é obrigatório';
    }
    final cleanPhone = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanPhone.length < 10 || cleanPhone.length > 11) {
      return 'Telefone inválido';
    }
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName é obrigatório';
    }
    return null;
  }
}
