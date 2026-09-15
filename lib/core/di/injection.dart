import 'package:get/get.dart';
import 'package:madperfume/core/network/api_client.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/core/services/storage_service.dart';
import 'package:madperfume/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:madperfume/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:madperfume/features/auth/domain/repositories/auth_repository.dart';
import 'package:madperfume/features/auth/presentation/controllers/auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ApiClient>()) {
      Get.put(ApiClient(), permanent: true);
    }
    if (!Get.isRegistered<AuthRemoteDatasource>()) {
      Get.put(AuthRemoteDatasource(Get.find<StorageService>()), permanent: true);
    }
    if (!Get.isRegistered<AuthRepository>()) {
      Get.put<AuthRepository>(
        AuthRepositoryImpl(Get.find<AuthRemoteDatasource>(), Get.find<StorageService>()),
        permanent: true,
      );
    }
    if (!Get.isRegistered<AuthController>()) {
      Get.put(
        AuthController(Get.find<AuthRepository>(), Get.find<SessionStore>()),
        permanent: true,
      );
    }
  }
}
