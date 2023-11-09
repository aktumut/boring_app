import 'package:boring_app/data/providers/logging_interceptor.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkProvider {
  late final Dio _dio;

  NetworkProvider() {
    _dio = Dio(
      BaseOptions(
        baseUrl: tTextBaseUrl,
        connectTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );

    _dio.interceptors.addAll([
      LoggingInterceptor(),
    ]);
  }

  Future<Response<T>> _httpWrapper<T>(
      Future<Response<T>> Function() dioCall) async {
    try {
      return await dioCall();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  Future<Response<T>> get<T>(String path) async {
    return _httpWrapper(() => _dio.get<T>(path));
  }
}
