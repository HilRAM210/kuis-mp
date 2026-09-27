import 'package:flutter/material.dart';

import '../../../core/widgets/category_chip.dart';
import '../../../core/widgets/product_card.dart';
import '../../categories/data/category_seeder.dart';
import '../data/product_seeder.dart';
import '../models/product.dart';
import '../controllers/favorite_controller.dart';
import 'product_detail_screen.dart';

/// Screen 1: daftar produk + filter kategori.
class ProductListScreen extends StatefulWidget {
  final FavoriteController favorites;

  const ProductListScreen({super.key, required this.favorites});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String? selectedCategoryId; // null = semua

  void _openDetail(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          product: product,
          favorites: widget.favorites,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = selectedCategoryId == null
        ? dummyProducts
        : dummyProducts
            .where((p) => p.category.id == selectedCategoryId)
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Produk Hewan')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: dummyCategories.length + 1,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CategoryChip(
                    label: 'Semua',
                    selected: selectedCategoryId == null,
                    onTap: () =>
                        setState(() => selectedCategoryId = null),
                  );
                }
                final cat = dummyCategories[index - 1];
                return CategoryChip(
                  label: cat.name,
                  selected: selectedCategoryId == cat.id,
                  onTap: () => setState(() =>
                      selectedCategoryId = cat.id),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListenableBuilder(
              listenable: widget.favorites,
              builder: (context, _) {
                if (filtered.isEmpty) {
                  return const Center(
                      child: Text('Tidak ada produk di kategori ini.'));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 285,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final product = filtered[index];
                    return ProductCard(
                      product: product,
                      isFavorite:
                          widget.favorites.isFavorite(product.id),
                      onTap: () => _openDetail(product),
                      onToggleFavorite: () =>
                          widget.favorites.toggle(product),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
