import 'package:get/get.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/features/loyalty/presentation/controllers/reward_details_controller.dart';

class RewardDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final id = Get.arguments as String? ?? CatalogData.rewards.first.id;
    Get.put(RewardDetailsController(CatalogData.rewardById(id)));
  }
}
