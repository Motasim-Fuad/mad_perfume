import 'package:get/get.dart';
import 'package:madperfume/features/profile/presentation/controllers/security_controller.dart';

class SecurityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SecurityController());
  }
}
