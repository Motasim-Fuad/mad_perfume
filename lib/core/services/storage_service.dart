import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class StorageService {
  StorageService(this._box);

  final GetStorage _box;

  T? read<T>(String key) => _box.read<T>(key);

  Future<void> write(String key, dynamic value) => _box.write(key, value);

  Future<void> remove(String key) => _box.remove(key);

  Map<String, dynamic>? readMap(String key) {
    final raw = _box.read(key);
    if (raw is Map<String, dynamic>) {
      return raw;
    }
    if (raw is String && raw.isNotEmpty) {
      return jsonDecode(raw) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> writeJson(String key, Object value) =>
      _box.write(key, jsonEncode(value));

  List<dynamic> readList(String key) {
    final raw = _box.read(key);
    if (raw is List) {
      return raw;
    }
    if (raw is String && raw.isNotEmpty) {
      return jsonDecode(raw) as List<dynamic>;
    }
    return const [];
  }
}
