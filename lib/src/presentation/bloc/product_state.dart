import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductEmpty extends ProductState {
  const ProductEmpty();
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object?> get props => [message];
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool favoritesOnly;

  /// Разовая ошибка действия (например, не удалось сохранить избранное).
  final String? actionError;

  const ProductLoaded(
    this.products, {
    this.favoritesOnly = false,
    this.actionError,
  });

  List<Product> get visible =>
      favoritesOnly ? products.where((p) => p.isFavorite).toList() : products;

  ProductLoaded copyWith({
    List<Product>? products,
    bool? favoritesOnly,
    String? actionError,
  }) =>
      ProductLoaded(
        products ?? this.products,
        favoritesOnly: favoritesOnly ?? this.favoritesOnly,
        actionError: actionError,
      );

  @override
  List<Object?> get props => [products, favoritesOnly, actionError];
}
