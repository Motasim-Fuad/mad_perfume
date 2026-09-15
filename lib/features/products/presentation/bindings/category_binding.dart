import 'package:get/get.dart';
import 'package:madperfume/features/products/presentation/controllers/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CategoryController.new, fenix: true);
  }
}
