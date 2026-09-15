import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/features/loyalty/data/models/points_entry.dart';

class LoyaltyController extends GetxController {
  SessionStore get session => Get.find<SessionStore>();

  String get tier {
    if (session.points.value >= 2000) {
      return 'platinum'.tr;
    }
    return 'platinum'.tr;
  }

  void openEarn() => Get.toNamed(AppRoutes.earnPoints);

  void openRewards() => Get.toNamed(AppRoutes.rewards);

  void openRedeemed() => Get.toNamed(AppRoutes.redeemedRewards);

  void openHistory() => Get.toNamed(AppRoutes.pointsHistory);

  List<PointsEntry> get recent => session.history.take(3).toList();
}

class RewardsController extends GetxController {
  SessionStore get session => Get.find<SessionStore>();
  final error = ''.obs;

  void open(String id) => Get.toNamed(AppRoutes.rewardDetails, arguments: id);
}

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

class PointsHistoryController extends GetxController {
  final filter = 'all'.obs;

  SessionStore get session => Get.find<SessionStore>();

  List<PointsEntry> get items {
    final all = session.history.toList();
    if (filter.value == 'earned') {
      return all.where((item) => item.type == PointsType.earned).toList();
    }
    if (filter.value == 'spent') {
      return all.where((item) => item.type == PointsType.spent).toList();
    }
    return all;
  }
}
