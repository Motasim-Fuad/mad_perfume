import 'package:get/get.dart';
import 'package:madperfume/features/cart/presentation/controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutController());
  }
}
