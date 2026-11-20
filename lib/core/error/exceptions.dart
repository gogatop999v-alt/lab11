/// Исключения Data Layer. Дальше repository они не уходят.
class AppException implements Exception {
  final String? message;
  const AppException([this.message]);
}

class NetworkException extends AppException {
  const NetworkException();
}

class ServerException extends AppException {
  final int? statusCode;
  const ServerException({this.statusCode});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException();
}

class ValidationException extends AppException {
  const ValidationException([super.message]);
}

class CacheException extends AppException {
  const CacheException();
}
