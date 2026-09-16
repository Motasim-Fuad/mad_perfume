class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.statusCode,
    this.fields = const {},
  });

  final String message;
  final int? statusCode;
  final Map<String, List<String>> fields;

  bool get isUnauthorized => statusCode == 401;

  static ApiException fromBody(int? statusCode, dynamic body) {
    if (body is! Map) {
      return ApiException(message: 'Request failed', statusCode: statusCode);
    }
    final map = Map<String, dynamic>.from(body);
    final fields = <String, List<String>>{};
    String? detail;
    map.forEach((key, value) {
      if (value is List) {
        fields[key] = value.map((item) => item.toString()).toList();
      } else if (key != 'detail' && value is String && value.isNotEmpty) {
        fields[key] = [value];
      }
    });
    final rawDetail = map['detail'];
    if (rawDetail is String) {
      detail = rawDetail;
    } else if (rawDetail is List && rawDetail.isNotEmpty) {
      detail = rawDetail.first.toString();
    }
    final firstField = fields.entries.where((entry) => entry.value.isNotEmpty);
    final message =
        detail ??
        (firstField.isEmpty ? 'Request failed' : firstField.first.value.first);
    return ApiException(
      message: message,
      statusCode: statusCode,
      fields: fields,
    );
  }

  @override
  String toString() => message;
}
