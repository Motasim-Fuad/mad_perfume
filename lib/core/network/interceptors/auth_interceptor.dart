import 'dart:async';

import 'package:dio/dio.dart';
import 'package:madperfume/core/constants/api_endpoints.dart';
import 'package:madperfume/core/error/api_exception.dart';
import 'package:madperfume/core/storage/token_store.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(this._tokens, this._dio);

  final TokenStore _tokens;
  final Dio _dio;
  Completer<void>? _refreshing;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final skip = options.extra['skipAuth'] == true;
    if (!skip && _tokens.access.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${_tokens.access}';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;
    final path = err.requestOptions.path;
    final alreadyRetried = err.requestOptions.extra['retried'] == true;
    final isRefresh = path.contains(ApiEndpoints.refresh);
    if (status != 401 ||
        alreadyRetried ||
        isRefresh ||
        err.requestOptions.extra['skipAuth'] == true) {
      handler.next(err);
      return;
    }
    try {
      await _refresh();
      final request = err.requestOptions;
      request.extra['retried'] = true;
      request.headers['Authorization'] = 'Bearer ${_tokens.access}';
      final response = await _dio.fetch<dynamic>(request);
      handler.resolve(response);
    } catch (_) {
      await _tokens.clear();
      handler.next(err);
    }
  }

  Future<void> _refresh() async {
    if (_refreshing != null) {
      return _refreshing!.future;
    }
    final pending = Completer<void>();
    _refreshing = pending;
    try {
      final refresh = _tokens.refresh;
      if (refresh.isEmpty) {
        throw ApiException(message: 'Session expired', statusCode: 401);
      }
      final refreshClient = Dio(
        BaseOptions(
          baseUrl: _dio.options.baseUrl,
          connectTimeout: _dio.options.connectTimeout,
          receiveTimeout: _dio.options.receiveTimeout,
          headers: const {'Accept': 'application/json'},
        ),
      );
      final response = await refreshClient.post<Map<String, dynamic>>(
        ApiEndpoints.refresh,
        data: {'refresh': refresh},
      );
      final data = response.data ?? {};
      final access = data['access']?.toString() ?? '';
      final nextRefresh = data['refresh']?.toString() ?? refresh;
      if (access.isEmpty) {
        throw ApiException(message: 'Session expired', statusCode: 401);
      }
      await _tokens.save(access: access, refresh: nextRefresh);
      pending.complete();
    } catch (error) {
      pending.completeError(error);
      rethrow;
    } finally {
      _refreshing = null;
    }
  }
}
