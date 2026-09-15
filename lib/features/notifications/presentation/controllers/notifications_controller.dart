import 'package:get/get.dart';
import 'package:madperfume/core/constants/catalog_data.dart';

class NotificationsController extends GetxController {
  final tab = 0.obs;

  List<AppNotification> get items {
    if (tab.value == 1) {
      return CatalogData.notifications.where((item) => item.category == 'offers').toList();
    }
    if (tab.value == 2) {
      return CatalogData.notifications.where((item) => item.category == 'reward').toList();
    }
    return CatalogData.notifications;
  }
}
