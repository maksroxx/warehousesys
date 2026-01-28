import 'dart:convert';
import 'package:dio/dio.dart';

class ErrorHandler {
  static String format(Object error) {
    if (error is DioException) {
      return _handleDioError(error);
    }
    if (error is String) {
      return error;
    }
    return "Произошла непредвиденная ошибка. Попробуйте позже.";
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "Время ожидания истекло. Проверьте интернет.";
      
      case DioExceptionType.connectionError:
        return "Нет соединения с сервером. Сервер недоступен.";

      case DioExceptionType.badResponse:
        return _handleStatsCode(error);

      case DioExceptionType.cancel:
        return "Запрос был отменен.";

      default:
        return "Ошибка сети. Попробуйте позже.";
    }
  }

  static String _handleStatsCode(DioException error) {
    final int statusCode = error.response?.statusCode ?? 500;
    
    final serverMessage = _tryParseServerMessage(error.response?.data);
    if (serverMessage != null && serverMessage.isNotEmpty) {
      return serverMessage;
    }

    switch (statusCode) {
      case 400:
        return "Неверный запрос (400).";
      case 401:
        return "Ошибка авторизации. Войдите снова.";
      case 403:
        return "Доступ запрещен (403).";
      case 404:
        return "Ресурс не найден (404).";
      case 500:
        return "Внутренняя ошибка сервера (500).";
      case 502:
        return "Сервер недоступен (Bad Gateway 502).";
      case 503:
        return "Сервис временно недоступен (503).";
      default:
        return "Ошибка сервера ($statusCode).";
    }
  }

  static String? _tryParseServerMessage(dynamic data) {
    try {
      if (data == null) return null;

      Map<String, dynamic> json;

      if (data is List<int>) {
        final decodedString = utf8.decode(data);
        json = jsonDecode(decodedString);
      } else if (data is Map<String, dynamic>) {
        json = data;
      } else {
        return null;
      }

      if (json.containsKey('error')) return json['error'];
      if (json.containsKey('message')) return json['message'];
      
    } catch (_) {
    }
    return null;
  }
}