import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/api_constants.dart';
import '../../src/data/datasources/product_local_datasource.dart';
import '../../src/data/datasources/product_remote_datasource.dart';
import '../../src/data/repositories/product_repository_impl.dart';
import '../../src/domain/repositories/product_repository.dart';
import '../../src/domain/usecases/get_products_usecase.dart';
import '../../src/domain/usecases/toggle_favorite_usecase.dart';
import '../../src/presentation/bloc/product_bloc.dart';
import '../rest_client/api_client.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // 1. External
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
      )));

  // 2. Core
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt()));

  // 3. Data sources
  getIt.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(getIt()));

  // 4. Repository
  getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remote: getIt(), local: getIt()));

  // 5. Use cases
  getIt.registerFactory(() => GetProductsUseCase(getIt()));
  getIt.registerFactory(() => ToggleFavoriteUseCase(getIt()));

  // 6. Bloc
  getIt.registerFactory(() => ProductBloc(
        getProducts: getIt(),
        toggleFavorite: getIt(),
      ));
}
