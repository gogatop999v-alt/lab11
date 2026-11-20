import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final double rating;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
    this.isFavorite = false,
  });

  Product copyWith({bool? isFavorite}) => Product(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        imageUrl: imageUrl,
        rating: rating,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  @override
  List<Object?> get props =>
      [id, title, price, description, category, imageUrl, rating, isFavorite];
}
