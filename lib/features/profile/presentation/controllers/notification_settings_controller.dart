import 'package:get/get.dart';
import 'package:madperfume/core/services/session_store.dart';

class NotificationSettingsController extends GetxController {
  SessionStore get session => Get.find<SessionStore>();

  Future<void> persist() => session.persistPrefs();
}
