import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';

class ShellController extends GetxController {
  final tabIndex = 0.obs;

  void setTab(int index) {
    tabIndex.value = index;
  }

  static Future<void> returnToMain({int tab = 0}) async {
    if (Get.isRegistered<ShellController>()) {
      Get.find<ShellController>().setTab(tab);
    }
    final nav = Get.key.currentState;
    if (nav != null && nav.canPop()) {
      nav.popUntil((route) {
        return route.settings.name == AppRoutes.main || route.isFirst;
      });
    }
    if (Get.currentRoute != AppRoutes.main) {
      Get.offAllNamed(AppRoutes.main);
    }
    if (Get.isRegistered<ShellController>()) {
      Get.find<ShellController>().setTab(tab);
    }
  }
}
