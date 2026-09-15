import 'package:get/get.dart';
import 'package:madperfume/core/di/injection.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/features/auth/domain/repositories/auth_repository.dart';
import 'package:madperfume/features/auth/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    InitialBinding().dependencies();
    if (!Get.isRegistered<AuthController>()) {
      Get.put(
        AuthController(Get.find<AuthRepository>(), Get.find<SessionStore>()),
        permanent: true,
      );
    }
  }
}
