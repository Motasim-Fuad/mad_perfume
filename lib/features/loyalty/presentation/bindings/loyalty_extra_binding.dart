import 'package:get/get.dart';
import 'package:madperfume/features/loyalty/presentation/controllers/points_history_controller.dart';
import 'package:madperfume/features/loyalty/presentation/controllers/rewards_controller.dart';

class LoyaltyExtraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(RewardsController.new, fenix: true);
    Get.lazyPut(PointsHistoryController.new, fenix: true);
  }
}
