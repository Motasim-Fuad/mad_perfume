import 'package:get/get.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/core/utils/field_wrap.dart';

class EditProfileController extends GetxController {
  final name = FieldWrap();
  final email = FieldWrap();
  final phone = FieldWrap();
  final address = FieldWrap();
  final error = ''.obs;
  final loading = false.obs;

  SessionStore get session => Get.find<SessionStore>();

  @override
  void onInit() {
    final user = session.user.value;
    name.controller.text = user?.fullName ?? '';
    email.controller.text = user?.email ?? '';
    phone.controller.text = user?.phone ?? '';
    address.controller.text = user?.address ?? '';
    super.onInit();
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
    super.onClose();
  }

  Future<void> save() async {
    error.value = '';
    final user = session.user.value;
    if (user == null) {
      return;
    }
    if (name.controller.text.trim().isEmpty) {
      error.value = 'required_field'.tr;
      return;
    }
    loading.value = true;
    await session.updateUser(
      user.copyWith(
        fullName: name.controller.text.trim(),
        email: email.controller.text.trim(),
        phone: phone.controller.text.trim(),
        address: address.controller.text.trim(),
      ),
    );
    loading.value = false;
    Get.back();
  }
}
