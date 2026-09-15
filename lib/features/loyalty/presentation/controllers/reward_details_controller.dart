import 'package:get/get.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/core/services/session_store.dart';

class RewardDetailsController extends GetxController {
  RewardDetailsController(this.reward);

  final RewardEntity reward;
  final error = ''.obs;
  final loading = false.obs;

  SessionStore get session => Get.find<SessionStore>();

  bool get already => session.redeemed.contains(reward.id);

  Future<void> redeem() async {
    error.value = '';
    loading.value = true;
    try {
      final result = await session.redeemReward(
        RewardEntityRef(id: reward.id, title: reward.title, points: reward.points),
      );
      if (result != null) {
        error.value = result.tr;
      }
    } finally {
      loading.value = false;
    }
  }
}
