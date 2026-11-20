import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/empty_view.dart';
import '../../../components/error_view.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Магазин'),
        actions: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is! ProductLoaded) return const SizedBox.shrink();
              return IconButton(
                tooltip: 'Только избранное',
                icon: Icon(state.favoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () => bloc.add(const ToggleFavoritesFilter()),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listenWhen: (_, s) => s is ProductLoaded && s.actionError != null,
        listener: (context, state) {
          final msg = (state as ProductLoaded).actionError!;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(msg)));
        },
        builder: (context, state) {
          if (state is ProductInitial || state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductError) {
            return ErrorView(
              message: state.message,
              onRetry: () => bloc.add(const LoadProducts(force: true)),
            );
          }
          if (state is ProductEmpty) {
            return EmptyView(
              message: 'Товаров пока нет',
              onRetry: () => bloc.add(const LoadProducts(force: true)),
            );
          }
          final loaded = state as ProductLoaded;
          final items = loaded.visible;

          return RefreshIndicator(
            onRefresh: () {
              final c = Completer<void>();
              bloc.add(RefreshProducts(completer: c));
              return c.future;
            },
            child: items.isEmpty
                ? ListView(children: const [
                    SizedBox(height: 120),
                    EmptyView(message: 'В избранном пока пусто'),
                  ])
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, i) => ProductCard(
                      product: items[i],
                      onFavorite: () => bloc.add(ToggleFavorite(items[i].id)),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
