import 'package:dio/dio.dart';
import 'package:madperfume/core/constants/api_endpoints.dart';
import 'package:madperfume/core/network/interceptors/auth_interceptor.dart';
import 'package:madperfume/core/utils/logger.dart';

class ApiClient {
  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: const {'Accept': 'application/json'},
      ),
    );
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => AppLogger.info(object.toString()),
      ),
    );
  }

  late final Dio _dio;

  Dio get dio => _dio;
}
