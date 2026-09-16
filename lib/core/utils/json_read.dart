class JsonRead {
  JsonRead._();

  static int integer(dynamic value, [int fallback = 0]) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse('$value') ?? fallback;
  }

  static int? integerOrNull(dynamic value) {
    if (value == null) {
      return null;
    }
    return integer(value);
  }

  static double money(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse('$value') ?? 0;
  }

  static String text(dynamic value) => value?.toString() ?? '';

  static bool flag(dynamic value, [bool fallback = false]) {
    if (value is bool) {
      return value;
    }
    return fallback;
  }

  static List<String> strings(dynamic value) {
    if (value is! List) {
      return const [];
    }
    return value.map((item) => item.toString()).toList();
  }

  static Map<String, dynamic> map(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return const {};
  }
}
