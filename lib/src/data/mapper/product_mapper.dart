import '../../../models/product_model.dart';
import '../../domain/entities/product.dart';

extension ProductModelMapper on ProductModel {
  Product toEntity({bool isFavorite = false}) => Product(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        imageUrl: image,
        rating: rating,
        isFavorite: isFavorite,
      );
}
