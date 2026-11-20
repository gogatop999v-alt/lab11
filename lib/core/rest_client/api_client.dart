import 'dart:io';

import 'package:dio/dio.dart';

import '../error/exceptions.dart';

/// Обёртка над Dio: переводит DioException в наши исключения.
class ApiClient {
  final Dio _dio;
  ApiClient(this._dio);

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(path, queryParameters: query);
      return response.data;
    } on DioException catch (e) {
      throw _map(e);
    }
  }

  AppException _map(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException();
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        if (code == 400) return const ValidationException();
        if (code == 401 || code == 403) return const UnauthorizedException();
        return ServerException(statusCode: code);
      default:
        if (e.error is SocketException) return const NetworkException();
        return const AppException();
    }
  }
}
