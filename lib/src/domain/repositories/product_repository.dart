import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();

  /// Возвращает новое состояние избранного (true — добавлен).
  Future<Either<Failure, bool>> toggleFavorite(int productId);
}
