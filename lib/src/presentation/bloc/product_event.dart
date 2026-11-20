import 'dart:async';

abstract class ProductEvent {
  const ProductEvent();
}

class LoadProducts extends ProductEvent {
  /// force = true для кнопки «Повторить»: игнорирует уже загруженные данные.
  final bool force;
  const LoadProducts({this.force = false});
}

class RefreshProducts extends ProductEvent {
  final Completer<void>? completer;
  const RefreshProducts({this.completer});
}

class ToggleFavorite extends ProductEvent {
  final int productId;
  const ToggleFavorite(this.productId);
}

class ToggleFavoritesFilter extends ProductEvent {
  const ToggleFavoritesFilter();
}
