extension StringX on String {
  String get trimmed => trim();

  bool get isBlank => trim().isEmpty;
}
