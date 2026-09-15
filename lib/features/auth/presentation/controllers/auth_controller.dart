import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/error/exceptions.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/core/utils/validators.dart';
import 'package:madperfume/features/auth/data/models/login_request.dart';
import 'package:madperfume/features/auth/domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
  AuthController(this._repository, this._session);

  final AuthRepository _repository;
  final SessionStore _session;

  final loginId = TextEditingController();
  final loginPassword = TextEditingController();
  final fullName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  final resetEmail = TextEditingController();
  final code = TextEditingController();

  final obscureLogin = true.obs;
  final obscureRegister = true.obs;
  final obscureConfirm = true.obs;
  final loading = false.obs;
  final actionError = ''.obs;
  final resendSeconds = 0.obs;

  @override
  void onClose() {
    loginId.dispose();
    loginPassword.dispose();
    fullName.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirm.dispose();
    resetEmail.dispose();
    code.dispose();
    super.onClose();
  }

  void clearError() => actionError.value = '';

  Future<void> login() async {
    clearError();
    final idError = Validators.required(loginId.text, 'required_field'.tr);
    final passError = Validators.password(loginPassword.text, 'invalid_password'.tr);
    if (idError != null) {
      actionError.value = idError;
      return;
    }
    if (passError != null) {
      actionError.value = passError;
      return;
    }
    loading.value = true;
    try {
      final result = await _repository.login(
        LoginRequest(identifier: loginId.text.trim(), password: loginPassword.text),
      );
      await _session.persistAuth(result.token, result.user);
      Get.offAllNamed(AppRoutes.main);
    } on AuthException catch (error) {
      actionError.value = 'login_failed'.tr;
      debugPrint(error.message);
    } finally {
      loading.value = false;
    }
  }

  Future<void> register() async {
    clearError();
    final nameError = Validators.required(fullName.text, 'required_field'.tr);
    final mailError = Validators.email(email.text, 'invalid_email'.tr);
    final phoneError = Validators.phone(phone.text, 'invalid_phone'.tr);
    final passError = Validators.password(password.text, 'invalid_password'.tr);
    final confirmError = Validators.confirm(confirm.text, password.text, 'password_mismatch'.tr);
    final first = nameError ?? mailError ?? phoneError ?? passError ?? confirmError;
    if (first != null) {
      actionError.value = first;
      return;
    }
    loading.value = true;
    try {
      final result = await _repository.register(
        fullName: fullName.text.trim(),
        email: email.text.trim(),
        phone: phone.text.trim(),
        password: password.text,
      );
      await _session.persistAuth(result.token, result.user);
      Get.offAllNamed(AppRoutes.main);
    } on AuthException {
      actionError.value = 'login_failed'.tr;
    } finally {
      loading.value = false;
    }
  }

  Future<void> social(String provider) async {
    clearError();
    loading.value = true;
    try {
      final result = await _repository.social(provider);
      await _session.persistAuth(result.token, result.user);
      Get.offAllNamed(AppRoutes.main);
    } finally {
      loading.value = false;
    }
  }

  Future<void> sendCode() async {
    clearError();
    final mailError = Validators.email(resetEmail.text, 'invalid_email'.tr);
    if (mailError != null) {
      actionError.value = mailError;
      return;
    }
    loading.value = true;
    try {
      await _repository.sendResetCode(resetEmail.text.trim());
      _startResend();
      Get.toNamed(AppRoutes.resetPassword);
    } on ValidationException catch (error) {
      actionError.value = error.message;
    } finally {
      loading.value = false;
    }
  }

  Future<void> verifyCode() async {
    clearError();
    if (code.text.trim().length != 6) {
      actionError.value = 'invalid_code'.tr;
      return;
    }
    loading.value = true;
    try {
      await _repository.verifyResetCode(resetEmail.text.trim(), code.text.trim());
      Get.offNamed(AppRoutes.login);
    } on ValidationException catch (error) {
      actionError.value = error.message;
    } finally {
      loading.value = false;
    }
  }

  Future<void> resend() async {
    if (resendSeconds.value > 0) {
      return;
    }
    await _repository.sendResetCode(resetEmail.text.trim());
    _startResend();
  }

  void _startResend() {
    resendSeconds.value = 30;
    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (resendSeconds.value <= 0) {
        return false;
      }
      resendSeconds.value -= 1;
      return resendSeconds.value > 0;
    });
  }

  Future<void> logout() async {
    await _repository.logout();
    await _session.clearAuth();
    Get.offAllNamed(AppRoutes.welcome);
  }
}
