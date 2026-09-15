import 'package:get/get.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/core/utils/field_wrap.dart';

class SecurityController extends GetxController {
  final current = FieldWrap();
  final next = FieldWrap();
  final confirm = FieldWrap();
  final error = ''.obs;
  final loading = false.obs;

  SessionStore get session => Get.find<SessionStore>();

  @override
  void onClose() {
    current.dispose();
    next.dispose();
    confirm.dispose();
    super.onClose();
  }

  Future<void> updatePassword() async {
    error.value = '';
    final user = session.user.value;
    if (user == null) {
      return;
    }
    if (user.password.isNotEmpty && current.controller.text != user.password) {
      error.value = 'login_failed'.tr;
      return;
    }
    if (next.controller.text.length < 6) {
      error.value = 'invalid_password'.tr;
      return;
    }
    if (next.controller.text != confirm.controller.text) {
      error.value = 'password_mismatch'.tr;
      return;
    }
    loading.value = true;
    await session.updateUser(user.copyWith(password: next.controller.text));
    loading.value = false;
    Get.back();
  }
}
