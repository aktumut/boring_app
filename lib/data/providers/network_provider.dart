import 'package:boring_app/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkProvider {
  late final Dio _dio;

  NetworkProvider() {
    _dio = Dio(
      BaseOptions(
        baseUrl: tTextBaseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
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
