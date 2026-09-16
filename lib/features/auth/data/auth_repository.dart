import 'package:madperfume/core/constants/api_endpoints.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/core/network/api_client.dart';
import 'package:madperfume/core/storage/token_store.dart';

class AuthRepository {
  AuthRepository(this._api, this._tokens);

  final ApiClient _api;
  final TokenStore _tokens;

  Future<ProfileModel> login({
    required String identifier,
    required String password,
  }) async {
    await _storeTokens(
      await _api.post<Map<String, dynamic>>(
        ApiEndpoints.login,
        data: {'identifier': identifier, 'password': password},
        auth: false,
        parse: _map,
      ),
    );
    return me();
  }

  Future<ProfileModel> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    await _storeTokens(
      await _api.post<Map<String, dynamic>>(
        ApiEndpoints.register,
        data: {
          'full_name': fullName,
          'email': email,
          'phone': phone,
          'password': password,
        },
        auth: false,
        parse: _map,
      ),
    );
    return me();
  }

  Future<ProfileModel> me() {
    return _api.get(
      ApiEndpoints.me,
      parse: (data) => ProfileModel.fromJson(_map(data)),
    );
  }

  Future<ProfileModel> updateMe(Map<String, dynamic> body) {
    return _api.patch(
      ApiEndpoints.me,
      data: body,
      parse: (data) => ProfileModel.fromJson(_map(data)),
    );
  }

  Future<void> changePassword({required String current, required String next}) {
    return _api.post<void>(
      ApiEndpoints.changePassword,
      data: {'current_password': current, 'password': next},
      parse: (_) {},
    );
  }

  Future<void> sendResetCode(String email) {
    return _api.post<void>(
      ApiEndpoints.passwordResetCode,
      data: {'email': email},
      auth: false,
      parse: (_) {},
    );
  }

  Future<({String uid, String token})> verifyResetCode({
    required String email,
    required String code,
  }) {
    return _api.post(
      ApiEndpoints.passwordResetVerify,
      data: {'email': email, 'code': code},
      auth: false,
      parse: (data) {
        final map = _map(data);
        return (uid: '${map['uid'] ?? ''}', token: '${map['token'] ?? ''}');
      },
    );
  }

  Future<void> confirmResetPassword({
    required String uid,
    required String token,
    required String password,
  }) {
    return _api.post<void>(
      ApiEndpoints.passwordResetConfirm,
      data: {'uid': uid, 'token': token, 'password': password},
      auth: false,
      parse: (_) {},
    );
  }

  Future<void> logout() async {
    final refresh = _tokens.refresh;
    try {
      if (refresh.isNotEmpty) {
        await _api.post<void>(
          ApiEndpoints.logout,
          data: {'refresh': refresh},
          auth: false,
          parse: (_) {},
        );
      }
    } catch (_) {}
    await _tokens.clear();
  }

  Future<void> _storeTokens(Map<String, dynamic> data) {
    return _tokens.save(
      access: '${data['access'] ?? ''}',
      refresh: '${data['refresh'] ?? ''}',
    );
  }

  Map<String, dynamic> _map(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return const {};
  }
}
