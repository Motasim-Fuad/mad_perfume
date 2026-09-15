import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/catalog_data.dart';

class BranchesController extends GetxController {
  final query = ''.obs;

  List<BranchEntity> get items {
    final q = query.value.trim().toLowerCase();
    if (q.isEmpty) {
      return CatalogData.branches;
    }
    return CatalogData.branches
        .where((item) => item.city.toLowerCase().contains(q) || item.address.toLowerCase().contains(q) || item.name.toLowerCase().contains(q))
        .toList();
  }

  void open(String id) => Get.toNamed(AppRoutes.branchDetails, arguments: id);
}
