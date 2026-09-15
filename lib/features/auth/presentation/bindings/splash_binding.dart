import 'package:get/get.dart';
import 'package:madperfume/core/di/injection.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    InitialBinding().dependencies();
  }
}
