import 'package:dartz/dartz.dart';

import 'exceptions.dart';
import 'failures.dart';

/// Единственное место, где исключения Data Layer превращаются в Failure.
Future<Either<Failure, T>> guard<T>(Future<T> Function() action) async {
  try {
    return Right(await action());
  } on NetworkException {
    return Left(const NetworkFailure());
  } on UnauthorizedException {
    return Left(const UnauthorizedFailure());
  } on ValidationException {
    return Left(const ValidationFailure());
  } on ServerException {
    return Left(const ServerFailure());
  } on CacheException {
    return Left(const CacheFailure());
  } catch (_) {
    return Left(const UnknownFailure());
  }
}
