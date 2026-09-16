import 'package:madperfume/core/constants/storage_keys.dart';
import 'package:madperfume/core/services/storage_service.dart';

class TokenStore {
  TokenStore(this._storage);

  final StorageService _storage;

  String get access => _storage.read<String>(StorageKeys.accessToken) ?? '';

  String get refresh => _storage.read<String>(StorageKeys.refreshToken) ?? '';

  bool get hasSession => access.isNotEmpty;

  Future<void> save({required String access, required String refresh}) async {
    await _storage.write(StorageKeys.accessToken, access);
    await _storage.write(StorageKeys.refreshToken, refresh);
  }

  Future<void> clear() async {
    await _storage.remove(StorageKeys.accessToken);
    await _storage.remove(StorageKeys.refreshToken);
  }
}
