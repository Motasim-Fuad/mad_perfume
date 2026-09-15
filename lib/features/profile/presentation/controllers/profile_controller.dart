import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/features/auth/presentation/controllers/auth_controller.dart';
import 'package:madperfume/features/orders/data/models/order_model.dart';

class ProfileController extends GetxController {
  SessionStore get session => Get.find<SessionStore>();

  List<OrderModel> get orders => session.orders;

  List<OrderModel> get recentOrders => orders.take(4).toList();

  List<ProductEntity> get saved {
    return CatalogData.products.where((item) => session.wishlist.contains(item.id)).toList();
  }

  void openSettings() => Get.toNamed(AppRoutes.settings);

  void openSaved() => Get.toNamed(AppRoutes.savedItems);

  void openAllOrders() => Get.toNamed(AppRoutes.allOrders);

  void openOrder(String id) => Get.toNamed(AppRoutes.orderDetails, arguments: id);

  void openTracking(String id) => Get.toNamed(AppRoutes.orderTracking, arguments: id);
}

class SettingsController extends GetxController {
  void editProfile() => Get.toNamed(AppRoutes.editProfile);

  void security() => Get.toNamed(AppRoutes.security);

  void notifications() => Get.toNamed(AppRoutes.notificationSettings);

  Future<void> logout() => Get.find<AuthController>().logout();
}

class EditProfileController extends GetxController {
  final name = TextWrap2();
  final email = TextWrap2();
  final phone = TextWrap2();
  final address = TextWrap2();
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

class SecurityController extends GetxController {
  final current = TextWrap2();
  final next = TextWrap2();
  final confirm = TextWrap2();
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

class NotificationSettingsController extends GetxController {
  SessionStore get session => Get.find<SessionStore>();

  Future<void> persist() => session.persistPrefs();
}

class TextWrap2 {
  final controller = TextEditingController();
  void dispose() => controller.dispose();
}
