import 'package:get/get.dart';
import 'package:madperfume/core/di/locator.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    setupLocator();
  }
}
