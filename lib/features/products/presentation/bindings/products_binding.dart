import 'package:get/get.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/features/products/presentation/controllers/category_controller.dart';
import 'package:madperfume/features/products/presentation/controllers/product_details_controller.dart';
import 'package:madperfume/features/products/presentation/controllers/product_list_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CategoryController.new, fenix: true);
  }
}

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    final id = Get.arguments as String? ?? CatalogData.collections.first.id;
    Get.put(ProductListController(id));
  }
}

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final id = Get.arguments as String? ?? CatalogData.products.first.id;
    Get.put(ProductDetailsController(CatalogData.productById(id)));
  }
}
