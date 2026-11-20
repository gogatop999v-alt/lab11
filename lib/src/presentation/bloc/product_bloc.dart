import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProducts;
  final ToggleFavoriteUseCase toggleFavorite;

  ProductBloc({required this.getProducts, required this.toggleFavorite})
      : super(const ProductInitial()) {
    on<LoadProducts>(_onLoad);
    on<RefreshProducts>(_onRefresh);
    on<ToggleFavorite>(_onToggleFavorite);
    on<ToggleFavoritesFilter>(_onToggleFilter);
  }

  Future<void> _onLoad(LoadProducts event, Emitter<ProductState> emit) async {
    // Защита от повторных запросов.
    if (state is ProductLoading) return;
    if (state is ProductLoaded && !event.force) return;

    emit(const ProductLoading());
    await _fetch(emit);
  }

  Future<void> _onRefresh(
      RefreshProducts event, Emitter<ProductState> emit) async {
    try {
      await _fetch(emit, keepFilter: true);
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _fetch(Emitter<ProductState> emit,
      {bool keepFilter = false}) async {
    final onlyFav = keepFilter && state is ProductLoaded
        ? (state as ProductLoaded).favoritesOnly
        : false;

    final result = await getProducts();
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => products.isEmpty
          ? emit(const ProductEmpty())
          : emit(ProductLoaded(products, favoritesOnly: onlyFav)),
    );
  }

  Future<void> _onToggleFavorite(
      ToggleFavorite event, Emitter<ProductState> emit) async {
    final current = state;
    if (current is! ProductLoaded) return;

    final result = await toggleFavorite(event.productId);
    result.fold(
      (failure) => emit(current.copyWith(actionError: failure.message)),
      (isFav) => emit(current.copyWith(
        products: current.products
            .map((p) =>
                p.id == event.productId ? p.copyWith(isFavorite: isFav) : p)
            .toList(),
      )),
    );
  }

  void _onToggleFilter(
      ToggleFavoritesFilter event, Emitter<ProductState> emit) {
    final current = state;
    if (current is ProductLoaded) {
      emit(current.copyWith(favoritesOnly: !current.favoritesOnly));
    }
  }
}
