import 'package:get/get.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/features/branches/presentation/controllers/branch_details_controller.dart';

class BranchDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final id = Get.arguments as String? ?? CatalogData.branches.first.id;
    Get.put(BranchDetailsController(CatalogData.branchById(id)));
  }
}
