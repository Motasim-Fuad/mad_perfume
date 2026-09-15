import 'package:get/get.dart';
import 'package:madperfume/features/notifications/presentation/controllers/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationsController());
  }
}
