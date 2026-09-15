import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/features/orders/data/models/order_model.dart';

class ProfileController extends GetxController {
  SessionStore get session => Get.find<SessionStore>();

  List<OrderModel> get orders => session.orders;

  List<OrderModel> get recentOrders => orders.take(4).toList();

  List<ProductEntity> get saved {
    return CatalogData.products.where((item) => session.wishlist.contains(item.id)).toList();
  }

  void openSettings() => Get.toNamed(AppRoutes.settings);

  void openSaved() => Get.toNamed(AppRoutes.savedItems);

  void openAllOrders() => Get.toNamed(AppRoutes.allOrders);

  void openOrder(String id) => Get.toNamed(AppRoutes.orderDetails, arguments: id);

  void openTracking(String id) => Get.toNamed(AppRoutes.orderTracking, arguments: id);
}
