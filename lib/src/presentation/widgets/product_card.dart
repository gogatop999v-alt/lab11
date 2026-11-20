import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onFavorite;
  const ProductCard(
      {super.key, required this.product, required this.onFavorite});

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          leading: SizedBox(
            width: 56,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported),
            ),
          ),
          title: Text(product.title,
              maxLines: 2, overflow: TextOverflow.ellipsis),
          subtitle: Text(
              '\$${product.price.toStringAsFixed(2)} · ${product.category}'),
          trailing: IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: product.isFavorite ? Colors.red : null,
            ),
            onPressed: onFavorite,
          ),
        ),
      );
}
