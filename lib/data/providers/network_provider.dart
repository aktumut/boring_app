import 'package:boring_app/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkProvider {
  NetworkProvider() {
    _dio = Dio(
      BaseOptions(
        baseUrl: tTextBaseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
  }

  late final Dio _dio;

  Future<Response<T>> _httpWrapper<T>(
    Future<Response<T>> Function() dioCall,
  ) async {
    try {
      return await dioCall();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<Response<T>> get<T>(String path) async {
    return _httpWrapper(() => _dio.get<T>(path));
  }
}
