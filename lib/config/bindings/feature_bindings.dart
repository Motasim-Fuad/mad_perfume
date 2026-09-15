import 'package:get/get.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/features/branches/presentation/controllers/branches_controller.dart';
import 'package:madperfume/features/cart/presentation/controllers/cart_controller.dart';
import 'package:madperfume/features/loyalty/presentation/controllers/loyalty_controller.dart';
import 'package:madperfume/features/notifications/presentation/controllers/notifications_controller.dart';
import 'package:madperfume/features/orders/presentation/controllers/order_flow_controller.dart';
import 'package:madperfume/features/profile/presentation/controllers/profile_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutController());
  }
}

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationsController());
  }
}

class LoyaltyExtraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(RewardsController.new, fenix: true);
    Get.lazyPut(PointsHistoryController.new, fenix: true);
  }
}

class RewardDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final id = Get.arguments as String? ?? CatalogData.rewards.first.id;
    Get.put(RewardDetailsController(CatalogData.rewardById(id)));
  }
}

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
    Get.lazyPut(EditProfileController.new, fenix: true);
    Get.lazyPut(SecurityController.new, fenix: true);
    Get.lazyPut(NotificationSettingsController.new, fenix: true);
  }
}

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditProfileController());
  }
}

class SecurityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SecurityController());
  }
}

class NotificationSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationSettingsController());
  }
}

class BranchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BranchesController());
  }
}

class BranchDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final id = Get.arguments as String? ?? CatalogData.branches.first.id;
    Get.put(BranchDetailsController(CatalogData.branchById(id)));
  }
}

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
