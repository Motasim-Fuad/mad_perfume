import 'package:madperfume/features/auth/data/models/login_request.dart';
import 'package:madperfume/features/auth/data/models/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginRequest request);

  Future<LoginResponse> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });

  Future<LoginResponse> social(String provider);

  Future<void> sendResetCode(String email);

  Future<void> verifyResetCode(String email, String code);

  Future<void> logout();
}
