import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/error/guard.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';
import '../mapper/product_mapper.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  final ProductLocalDataSource local;

  ProductRepositoryImpl({required this.remote, required this.local});

  @override
  Future<Either<Failure, List<Product>>> getProducts() => guard(() async {
        final models = await remote.getProducts();
        final favorites = await _favoritesOrEmpty();
        return models
            .map((m) => m.toEntity(isFavorite: favorites.contains(m.id)))
            .toList();
      });

  @override
  Future<Either<Failure, bool>> toggleFavorite(int productId) =>
      guard(() async {
        final ids = {...await local.getFavoriteIds()};
        final added = ids.add(productId);
        if (!added) ids.remove(productId);
        await local.saveFavoriteIds(ids);
        return added;
      });

  /// Проблема с локальным хранилищем не должна ломать загрузку каталога.
  Future<Set<int>> _favoritesOrEmpty() async {
    try {
      return await local.getFavoriteIds();
    } catch (_) {
      return <int>{};
    }
  }
}
