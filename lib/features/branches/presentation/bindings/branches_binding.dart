import 'package:get/get.dart';
import 'package:madperfume/features/branches/presentation/controllers/branches_controller.dart';

class BranchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BranchesController());
  }
}
