import 'package:get/get.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/features/loyalty/data/models/points_entry.dart';

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
