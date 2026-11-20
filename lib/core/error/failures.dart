import 'package:equatable/equatable.dart';

/// Иерархия Failure. message — безопасный текст для пользователя.
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure(
      [super.message = 'Нет подключения к интернету. Проверьте соединение.']);
}

class ServerFailure extends Failure {
  const ServerFailure(
      [super.message = 'Ошибка сервера. Попробуйте позже.']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(
      [super.message = 'Требуется авторизация. Войдите в аккаунт.']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(
      [super.message = 'Некорректный запрос. Проверьте введённые данные.']);
}

class CacheFailure extends Failure {
  const CacheFailure(
      [super.message = 'Не удалось сохранить или прочитать локальные данные.']);
}

class UnknownFailure extends Failure {
  const UnknownFailure(
      [super.message = 'Произошла неизвестная ошибка. Попробуйте ещё раз.']);
}
