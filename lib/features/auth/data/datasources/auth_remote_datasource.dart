import 'package:madperfume/core/error/exceptions.dart';
import 'package:madperfume/core/services/storage_service.dart';
import 'package:madperfume/features/auth/data/models/login_request.dart';
import 'package:madperfume/features/auth/data/models/login_response.dart';
import 'package:madperfume/features/auth/data/models/user_model.dart';

class AuthRemoteDatasource {
  AuthRemoteDatasource(this._storage);

  final StorageService _storage;
  static const _usersKey = 'registered_users';

  Future<LoginResponse> login(LoginRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    final users = _loadUsers();
    UserModel? match;
    for (final user in users) {
      final id = request.identifier.trim().toLowerCase();
      final hit = user.email.toLowerCase() == id || user.phone.replaceAll(RegExp(r'\D'), '') == id.replaceAll(RegExp(r'\D'), '');
      if (hit && user.password == request.password) {
        match = user;
        break;
      }
    }
    if (match == null) {
      throw AuthException('Unable to sign in with these details');
    }
    return LoginResponse(token: 'local.${match.id}', user: match);
  }

  Future<LoginResponse> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    final users = _loadUsers();
    final exists = users.any((user) => user.email.toLowerCase() == email.toLowerCase());
    if (exists) {
      throw AuthException('Unable to sign in with these details');
    }
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
    );
    users.add(user);
    await _saveUsers(users);
    return LoginResponse(token: 'local.${user.id}', user: user);
  }

  Future<LoginResponse> social(String provider) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final user = UserModel(
      id: 'social-$provider',
      fullName: provider == 'apple' ? 'Alex Moreau' : 'Christian Dior',
      email: provider == 'apple' ? 'alex@madperfume.com' : 'name@example.com',
      phone: '+1 (555) 000-0000',
      password: '',
    );
    return LoginResponse(token: 'local.${user.id}', user: user);
  }

  Future<void> sendResetCode(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (!email.contains('@')) {
      throw ValidationException('Enter a valid email');
    }
  }

  Future<void> verifyResetCode(String email, String code) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (code.length != 6) {
      throw ValidationException('Enter the 6-digit code');
    }
  }

  List<UserModel> _loadUsers() {
    final raw = _storage.readList(_usersKey);
    final users = raw
        .whereType<Map>()
        .map((item) => UserModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
    if (!users.any((user) => user.email.toLowerCase() == 'name@example.com')) {
      users.add(
        const UserModel(
          id: 'demo',
          fullName: 'Christian Dior',
          email: 'name@example.com',
          phone: '+1 (555) 000-0000',
          password: '123456',
        ),
      );
    }
    return users;
  }

  Future<void> _saveUsers(List<UserModel> users) {
    return _storage.writeJson(_usersKey, users.map((user) => user.toJson()).toList());
  }
}
