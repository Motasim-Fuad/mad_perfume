import 'package:madperfume/core/constants/storage_keys.dart';
import 'package:madperfume/core/services/storage_service.dart';
import 'package:madperfume/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:madperfume/features/auth/data/models/login_request.dart';
import 'package:madperfume/features/auth/data/models/login_response.dart';
import 'package:madperfume/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._storage);

  final AuthRemoteDatasource _remote;
  final StorageService _storage;

  @override
  Future<LoginResponse> login(LoginRequest request) {
    return _remote.login(request);
  }

  @override
  Future<LoginResponse> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) {
    return _remote.register(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
    );
  }

  @override
  Future<LoginResponse> social(String provider) {
    return _remote.social(provider);
  }

  @override
  Future<void> sendResetCode(String email) {
    return _remote.sendResetCode(email);
  }

  @override
  Future<void> verifyResetCode(String email, String code) {
    return _remote.verifyResetCode(email, code);
  }

  @override
  Future<void> logout() async {
    await _storage.remove(StorageKeys.token);
    await _storage.remove(StorageKeys.user);
  }
}
