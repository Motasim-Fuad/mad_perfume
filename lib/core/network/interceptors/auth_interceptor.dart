import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:madperfume/core/constants/storage_keys.dart';
import 'package:madperfume/core/services/storage_service.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (Get.isRegistered<StorageService>()) {
      final token = Get.find<StorageService>().read<String>(StorageKeys.token);
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }
}
