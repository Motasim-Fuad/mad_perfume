import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/features/orders/data/models/order_model.dart';
import 'package:madperfume/features/shell/presentation/controllers/shell_controller.dart';

class OrderFlowController extends GetxController {
  OrderFlowController(this.orderId);

  final String orderId;

  SessionStore get session => Get.find<SessionStore>();

  OrderModel get order {
    return session.orders.firstWhere((item) => item.id == orderId);
  }

  void track() => Get.toNamed(AppRoutes.orderTracking, arguments: orderId);

  void home() {
    ShellController.returnToMain();
  }

  bool isReviewed(String productId) {
    return order.reviewedProductIds.contains(productId);
  }

  void review(String productId) {
    if (isReviewed(productId)) {
      return;
    }
    Get.toNamed(
      AppRoutes.writeReview,
      arguments: {'orderId': orderId, 'productId': productId},
    );
  }
}
