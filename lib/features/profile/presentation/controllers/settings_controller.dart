import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/features/auth/presentation/controllers/auth_controller.dart';

class SettingsController extends GetxController {
  void editProfile() => Get.toNamed(AppRoutes.editProfile);

  void security() => Get.toNamed(AppRoutes.security);

  void notifications() => Get.toNamed(AppRoutes.notificationSettings);

  Future<void> logout() => Get.find<AuthController>().logout();
}
