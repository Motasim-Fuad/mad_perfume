import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/services/session_store.dart';

class RewardsController extends GetxController {
  SessionStore get session => Get.find<SessionStore>();
  final error = ''.obs;

  void open(String id) => Get.toNamed(AppRoutes.rewardDetails, arguments: id);
}
