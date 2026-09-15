import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/catalog_data.dart';

class ProductListController extends GetxController {
  ProductListController(this.collectionId);

  final String collectionId;
  final search = ''.obs;
  final sortNewest = true.obs;

  CollectionEntity get collection => CatalogData.collectionById(collectionId);

  List<ProductEntity> get items {
    var list = CatalogData.byCollection(collectionId);
    final q = search.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      list = list.where((item) => item.name.toLowerCase().contains(q)).toList();
    }
    if (!sortNewest.value) {
      list = [...list]..sort((a, b) => a.price.compareTo(b.price));
    }
    return list;
  }

  void openDetails(String id) => Get.toNamed(AppRoutes.productDetails, arguments: id);
}
