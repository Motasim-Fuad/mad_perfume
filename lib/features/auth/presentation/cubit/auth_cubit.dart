import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/error/api_exception.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/core/storage/token_store.dart';
import 'package:madperfume/core/utils/validators.dart';
import 'package:madperfume/features/auth/data/auth_repository.dart';

class AuthState extends Equatable {
  const AuthState({
    this.profile,
    this.ready = false,
    this.loading = false,
    this.error = '',
    this.obscureLogin = true,
    this.obscureRegister = true,
    this.obscureConfirm = true,
    this.resendSeconds = 0,
  });

  final ProfileModel? profile;
  final bool ready;
  final bool loading;
  final String error;
  final bool obscureLogin;
  final bool obscureRegister;
  final bool obscureConfirm;
  final int resendSeconds;

  bool get isLoggedIn => profile != null;

  AuthState copyWith({
    ProfileModel? profile,
    bool clearProfile = false,
    bool? ready,
    bool? loading,
    String? error,
    bool? obscureLogin,
    bool? obscureRegister,
    bool? obscureConfirm,
    int? resendSeconds,
  }) {
    return AuthState(
      profile: clearProfile ? null : (profile ?? this.profile),
      ready: ready ?? this.ready,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      obscureLogin: obscureLogin ?? this.obscureLogin,
      obscureRegister: obscureRegister ?? this.obscureRegister,
      obscureConfirm: obscureConfirm ?? this.obscureConfirm,
      resendSeconds: resendSeconds ?? this.resendSeconds,
    );
  }

  @override
  List<Object?> get props => [
    profile,
    ready,
    loading,
    error,
    obscureLogin,
    obscureRegister,
    obscureConfirm,
    resendSeconds,
  ];
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository, this._tokens) : super(const AuthState());

  final AuthRepository _repository;
  final TokenStore _tokens;

  final loginId = TextEditingController();
  final loginPassword = TextEditingController();
  final fullName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  final resetEmail = TextEditingController();
  final code = TextEditingController();
  final newPassword = TextEditingController();
  final newPasswordConfirm = TextEditingController();

  String? _resetUid;
  String? _resetToken;

  Future<void> restore() async {
    if (!_tokens.hasSession) {
      emit(state.copyWith(ready: true, clearProfile: true));
      return;
    }
    try {
      final profile = await _repository.me();
      emit(state.copyWith(profile: profile, ready: true, error: ''));
    } catch (_) {
      await _tokens.clear();
      emit(state.copyWith(ready: true, clearProfile: true));
    }
  }

  void clearError() => emit(state.copyWith(error: ''));

  void socialUnavailable() =>
      emit(state.copyWith(error: 'social_unavailable'.tr));

  void toggleLoginObscure() =>
      emit(state.copyWith(obscureLogin: !state.obscureLogin));

  void toggleRegisterObscure() =>
      emit(state.copyWith(obscureRegister: !state.obscureRegister));

  void toggleConfirmObscure() =>
      emit(state.copyWith(obscureConfirm: !state.obscureConfirm));

  Future<void> login() async {
    emit(state.copyWith(error: ''));
    final idError = Validators.required(loginId.text, 'required_field'.tr);
    final passError = Validators.required(
      loginPassword.text,
      'required_field'.tr,
    );
    if (idError != null || passError != null) {
      emit(state.copyWith(error: idError ?? passError ?? ''));
      return;
    }
    emit(state.copyWith(loading: true, error: ''));
    try {
      final profile = await _repository.login(
        identifier: loginId.text.trim(),
        password: loginPassword.text,
      );
      emit(state.copyWith(profile: profile, loading: false, error: ''));
      Get.offAllNamed(AppRoutes.main);
    } on ApiException catch (error) {
      emit(state.copyWith(loading: false, error: error.message));
    }
  }

  Future<void> register() async {
    emit(state.copyWith(error: ''));
    final first =
        Validators.required(fullName.text, 'required_field'.tr) ??
        Validators.email(email.text, 'invalid_email'.tr) ??
        Validators.phone(phone.text, 'invalid_phone'.tr) ??
        Validators.password(password.text, 'invalid_password'.tr) ??
        Validators.confirm(confirm.text, password.text, 'password_mismatch'.tr);
    if (first != null) {
      emit(state.copyWith(error: first));
      return;
    }
    emit(state.copyWith(loading: true, error: ''));
    try {
      final profile = await _repository.register(
        fullName: fullName.text.trim(),
        email: email.text.trim(),
        phone: phone.text.trim(),
        password: password.text,
      );
      emit(state.copyWith(profile: profile, loading: false, error: ''));
      Get.offAllNamed(AppRoutes.main);
    } on ApiException catch (error) {
      emit(state.copyWith(loading: false, error: error.message));
    }
  }

  Future<void> sendCode() async {
    final mailError = Validators.email(resetEmail.text, 'invalid_email'.tr);
    if (mailError != null) {
      emit(state.copyWith(error: mailError));
      return;
    }
    emit(state.copyWith(loading: true, error: ''));
    try {
      await _repository.sendResetCode(resetEmail.text.trim());
      emit(state.copyWith(loading: false, error: ''));
      _startResend();
      Get.toNamed(AppRoutes.resetPassword);
    } on ApiException catch (error) {
      emit(state.copyWith(loading: false, error: error.message));
    }
  }

  Future<void> completeReset() async {
    if (code.text.trim().length != 6) {
      emit(state.copyWith(error: 'invalid_code'.tr));
      return;
    }
    final passError =
        Validators.password(newPassword.text, 'invalid_password'.tr) ??
        Validators.confirm(
          newPasswordConfirm.text,
          newPassword.text,
          'password_mismatch'.tr,
        );
    if (passError != null) {
      emit(state.copyWith(error: passError));
      return;
    }
    emit(state.copyWith(loading: true, error: ''));
    try {
      final verified = await _repository.verifyResetCode(
        email: resetEmail.text.trim(),
        code: code.text.trim(),
      );
      _resetUid = verified.uid;
      _resetToken = verified.token;
      await _repository.confirmResetPassword(
        uid: _resetUid ?? '',
        token: _resetToken ?? '',
        password: newPassword.text,
      );
      emit(state.copyWith(loading: false, error: ''));
      Get.offAllNamed(AppRoutes.login);
    } on ApiException catch (error) {
      emit(state.copyWith(loading: false, error: error.message));
    }
  }

  Future<void> resend() async {
    if (state.resendSeconds > 0) {
      return;
    }
    await _repository.sendResetCode(resetEmail.text.trim());
    _startResend();
  }

  void _startResend() {
    emit(state.copyWith(resendSeconds: 30));
    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (isClosed || state.resendSeconds <= 0) {
        return false;
      }
      emit(state.copyWith(resendSeconds: state.resendSeconds - 1));
      return state.resendSeconds > 0;
    });
  }

  Future<void> refreshProfile() async {
    if (!_tokens.hasSession) {
      return;
    }
    try {
      final profile = await _repository.me();
      emit(state.copyWith(profile: profile));
    } on ApiException catch (_) {}
  }

  Future<ProfileModel?> patchProfile(Map<String, dynamic> body) async {
    try {
      final profile = await _repository.updateMe(body);
      emit(state.copyWith(profile: profile, error: ''));
      return profile;
    } on ApiException catch (error) {
      emit(state.copyWith(error: error.message));
      return null;
    }
  }

  Future<ProfileModel?> uploadAvatar(XFile image) async {
    try {
      final profile = await _repository.uploadAvatar(
        bytes: await image.readAsBytes(),
        filename: image.name,
      );
      emit(state.copyWith(profile: profile, error: ''));
      return profile;
    } on ApiException catch (error) {
      emit(state.copyWith(error: error.message));
      return null;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    emit(state.copyWith(clearProfile: true, error: '', ready: true));
    Get.offAllNamed(AppRoutes.welcome);
  }

  @override
  Future<void> close() {
    loginId.dispose();
    loginPassword.dispose();
    fullName.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirm.dispose();
    resetEmail.dispose();
    code.dispose();
    newPassword.dispose();
    newPasswordConfirm.dispose();
    return super.close();
  }
}
