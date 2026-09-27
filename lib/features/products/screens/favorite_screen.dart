import 'package:flutter/material.dart';

import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/product_card.dart';
import '../controllers/favorite_controller.dart';
import 'product_detail_screen.dart';

/// Screen 2: daftar item yang difavoritkan (reuse ProductCard).
class FavoriteScreen extends StatelessWidget {
  final FavoriteController favorites;

  const FavoriteScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorit Saya')),
      body: ListenableBuilder(
        listenable: favorites,
        builder: (context, _) {
          final items = favorites.favorites;
          if (items.isEmpty) {
            return const EmptyState(
              title: 'Belum ada favorit',
              subtitle:
                  'Ketuk ikon hati di produk untuk menyimpannya di sini.',
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 285,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];
              return ProductCard(
                product: product,
                isFavorite: true,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      product: product,
                      favorites: favorites,
                    ),
                  ),
                ),
                onToggleFavorite: () => favorites.toggle(product),
              );
            },
          );
        },
      ),
    );
  }
}
