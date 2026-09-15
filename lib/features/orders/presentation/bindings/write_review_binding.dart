import 'package:get/get.dart';
import 'package:madperfume/features/orders/presentation/controllers/write_review_controller.dart';

class WriteReviewBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map? ?? {};
    Get.put(
      WriteReviewController(
        args['orderId']?.toString() ?? '',
        args['productId']?.toString() ?? '',
      ),
    );
  }
}
