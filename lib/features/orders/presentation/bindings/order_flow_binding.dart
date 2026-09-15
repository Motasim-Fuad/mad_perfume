import 'package:get/get.dart';
import 'package:madperfume/features/orders/presentation/controllers/order_flow_controller.dart';

class OrderFlowBinding extends Bindings {
  @override
  void dependencies() {
    final id = Get.arguments as String? ?? '';
    if (Get.isRegistered<OrderFlowController>()) {
      final current = Get.find<OrderFlowController>();
      if (current.orderId != id) {
        Get.delete<OrderFlowController>();
        Get.put(OrderFlowController(id));
      }
    } else {
      Get.put(OrderFlowController(id));
    }
  }
}
