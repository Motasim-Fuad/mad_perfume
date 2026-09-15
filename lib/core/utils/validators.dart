class Validators {
  Validators._();

  static String? required(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? email(String? value, String message) {
    final trimmed = value?.trim() ?? '';
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(trimmed)) {
      return message;
    }
    return null;
  }

  static String? phone(String? value, String message) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    if (digits.length < 8) {
      return message;
    }
    return null;
  }

  static String? password(String? value, String message) {
    if ((value ?? '').length < 6) {
      return message;
    }
    return null;
  }

  static String? confirm(String? value, String original, String message) {
    if (value != original) {
      return message;
    }
    return null;
  }
}
