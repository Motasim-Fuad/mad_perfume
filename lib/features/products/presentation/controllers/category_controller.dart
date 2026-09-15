import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/catalog_data.dart';

class CategoryController extends GetxController {
  List<CollectionEntity> get collections => CatalogData.collections;

  void open(String id) => Get.toNamed(AppRoutes.productList, arguments: id);
}
