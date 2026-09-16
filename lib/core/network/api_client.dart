import 'package:dio/dio.dart';
import 'package:madperfume/core/constants/api_endpoints.dart';
import 'package:madperfume/core/error/api_exception.dart';
import 'package:madperfume/core/network/interceptors/auth_interceptor.dart';
import 'package:madperfume/core/storage/token_store.dart';
import 'package:madperfume/core/utils/logger.dart';

class ApiClient {
  ApiClient(this._tokens) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: const {'Accept': 'application/json'},
      ),
    );
    _dio.interceptors.add(AuthInterceptor(_tokens, _dio));
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => AppLogger.info(object.toString()),
      ),
    );
  }

  final TokenStore _tokens;
  late final Dio _dio;

  Dio get dio => _dio;

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? query,
    bool auth = true,
    T Function(dynamic data)? parse,
  }) {
    return _send(
      () => _dio.get<dynamic>(
        path,
        queryParameters: _clean(query),
        options: Options(extra: {'skipAuth': !auth}),
      ),
      parse: parse,
    );
  }

  Future<T> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
    bool auth = true,
    T Function(dynamic data)? parse,
  }) {
    return _send(
      () => _dio.post<dynamic>(
        path,
        data: data,
        options: Options(headers: headers, extra: {'skipAuth': !auth}),
      ),
      parse: parse,
    );
  }

  Future<T> patch<T>(
    String path, {
    Object? data,
    bool auth = true,
    T Function(dynamic data)? parse,
  }) {
    return _send(
      () => _dio.patch<dynamic>(
        path,
        data: data,
        options: Options(extra: {'skipAuth': !auth}),
      ),
      parse: parse,
    );
  }

  Future<void> delete(String path, {bool auth = true}) {
    return _send<void>(
      () => _dio.delete<dynamic>(
        path,
        options: Options(extra: {'skipAuth': !auth}),
      ),
      parse: (_) {},
    );
  }

  Map<String, dynamic>? _clean(Map<String, dynamic>? query) {
    if (query == null) {
      return null;
    }
    final out = <String, dynamic>{};
    query.forEach((key, value) {
      if (value != null && '$value'.isNotEmpty) {
        out[key] = value;
      }
    });
    return out;
  }

  Future<T> _send<T>(
    Future<Response<dynamic>> Function() request, {
    T Function(dynamic data)? parse,
  }) async {
    try {
      final response = await request();
      final code = response.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        if (parse == null) {
          return null as T;
        }
        return parse(response.data);
      }
      throw ApiException.fromBody(code, response.data);
    } on DioException catch (error) {
      if (error.error is ApiException) {
        throw error.error!;
      }
      final data = error.response?.data;
      throw ApiException.fromBody(error.response?.statusCode, data);
    }
  }
}
