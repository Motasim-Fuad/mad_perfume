import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/services/session_store.dart';

class CartController extends GetxController {
  SessionStore get session => Get.find<SessionStore>();

  void checkout() {
    if (session.cart.isEmpty) {
      return;
    }
    Get.toNamed(AppRoutes.checkout);
  }
}
