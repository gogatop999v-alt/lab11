import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class ToggleFavoriteUseCase {
  final ProductRepository repository;
  ToggleFavoriteUseCase(this.repository);

  Future<Either<Failure, bool>> call(int productId) =>
      repository.toggleFavorite(productId);
}
