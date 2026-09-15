import 'package:get/get.dart';
import 'package:madperfume/core/utils/field_wrap.dart';
import 'package:madperfume/core/services/session_store.dart';

class WriteReviewController extends GetxController {
  WriteReviewController(this.orderId, this.productId);

  final String orderId;
  final String productId;
  final rating = 5.obs;
  final body = FieldWrap();
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
