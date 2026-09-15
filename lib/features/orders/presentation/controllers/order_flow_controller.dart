import 'package:flutter/material.dart';
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

class WriteReviewController extends GetxController {
  WriteReviewController(this.orderId, this.productId);

  final String orderId;
  final String productId;
  final rating = 5.obs;
  final body = TextWrap3();
  final error = ''.obs;

  @override
  void onClose() {
    body.dispose();
    super.onClose();
  }

  Future<void> submit() async {
    error.value = '';
    final session = Get.find<SessionStore>();
    final already = session.orders.any(
      (order) => order.id == orderId && order.reviewedProductIds.contains(productId),
    );
    if (already) {
      error.value = 'already_reviewed'.tr;
      return;
    }
    if (body.controller.text.trim().isEmpty) {
      error.value = 'review_hint'.tr;
      return;
    }
    await session.markReviewed(orderId, productId);
    Get.back();
  }
}

class TextWrap3 {
  final controller = TextEditingController();
  void dispose() => controller.dispose();
}
