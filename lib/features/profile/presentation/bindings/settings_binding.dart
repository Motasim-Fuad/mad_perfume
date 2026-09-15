import 'package:get/get.dart';
import 'package:madperfume/features/profile/presentation/controllers/edit_profile_controller.dart';
import 'package:madperfume/features/profile/presentation/controllers/notification_settings_controller.dart';
import 'package:madperfume/features/profile/presentation/controllers/security_controller.dart';
import 'package:madperfume/features/profile/presentation/controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
    Get.lazyPut(EditProfileController.new, fenix: true);
    Get.lazyPut(SecurityController.new, fenix: true);
    Get.lazyPut(NotificationSettingsController.new, fenix: true);
  }
}
