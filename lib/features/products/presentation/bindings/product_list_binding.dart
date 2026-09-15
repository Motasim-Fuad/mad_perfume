import 'package:get/get.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/features/products/presentation/controllers/product_list_controller.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    final id = Get.arguments as String? ?? CatalogData.collections.first.id;
    Get.put(ProductListController(id));
  }
}
