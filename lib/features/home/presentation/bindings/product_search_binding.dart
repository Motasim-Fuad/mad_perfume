import 'package:get/get.dart';
import 'package:madperfume/features/home/presentation/controllers/product_search_controller.dart';

class ProductSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductSearchController());
  }
}
