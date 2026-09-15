import 'package:get/get.dart';
import 'package:madperfume/core/di/injection.dart';
import 'package:madperfume/features/cart/presentation/controllers/cart_controller.dart';
import 'package:madperfume/features/home/presentation/controllers/home_controller.dart';
import 'package:madperfume/features/loyalty/presentation/controllers/loyalty_controller.dart';
import 'package:madperfume/features/products/presentation/controllers/category_controller.dart';
import 'package:madperfume/features/profile/presentation/controllers/profile_controller.dart';
import 'package:madperfume/features/shell/presentation/controllers/shell_controller.dart';

class ShellBinding extends Bindings {
  @override
  void dependencies() {
    InitialBinding().dependencies();
    _ensure(ShellController.new);
    _ensure(HomeController.new);
    _ensure(CategoryController.new);
    _ensure(CartController.new);
    _ensure(LoyaltyController.new);
    _ensure(ProfileController.new);
  }

  void _ensure<T>(T Function() factory) {
    if (!Get.isRegistered<T>()) {
      Get.put<T>(factory(), permanent: true);
    }
  }
}
