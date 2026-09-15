import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
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
