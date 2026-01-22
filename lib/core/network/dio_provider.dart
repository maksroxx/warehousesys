import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/core/network/token_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080/api/v1',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await TokenStorage.getToken();
      
      print('>>> INTERCEPTOR: URL: ${options.path}');
      if (token != null) {
        print('>>> INTERCEPTOR: Токен найден! (первые 10 симв): ${token.substring(0, 10)}...');
        options.headers['Authorization'] = 'Bearer $token';
      } else {
        print('>>> INTERCEPTOR: ❌ Токен равен NULL. Запрос уйдет без авторизации.');
      }
      // -----------------------------

      return handler.next(options);
    },
    onError: (DioException e, handler) {
      print('<<< ERROR: ${e.response?.statusCode} | ${e.response?.data}');
      return handler.next(e);
    },
  ));

  return dio;
});