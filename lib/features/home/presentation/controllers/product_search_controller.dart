import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/catalog_data.dart';

class ProductSearchController extends GetxController {
  final query = ''.obs;

  List<ProductEntity> get results {
    final q = query.value.trim().toLowerCase();
    if (q.isEmpty) {
      return CatalogData.products;
    }
    return CatalogData.products.where((item) {
      final collection = CatalogData.collectionById(item.collectionId).nameKey.tr.toLowerCase();
      return item.name.toLowerCase().contains(q) ||
          item.volume.toLowerCase().contains(q) ||
          item.tags.any((tag) => tag.toLowerCase().contains(q)) ||
          item.collectionId.toLowerCase().contains(q) ||
          collection.contains(q);
    }).toList();
  }

  void open(String id) => Get.toNamed(AppRoutes.productDetails, arguments: id);
}
