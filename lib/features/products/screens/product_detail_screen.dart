import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formaters/currency_formatter.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/discount_badge.dart';
import '../../../core/widgets/price_tag.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/stock_badge.dart';
import '../controllers/favorite_controller.dart';
import '../models/discounted_product.dart';
import '../models/product.dart';

/// Screen 3: detail satu produk.
class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final FavoriteController favorites;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    final isDiscounted = product is DiscountedProduct &&
        (product as DiscountedProduct).discountPercentage > 0;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: ListenableBuilder(
        listenable: favorites,
        builder: (context, _) {
          final liked = favorites.isFavorite(product.id);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AppNetworkImage(url: product.imageUrl, height: 260),
                    if (isDiscounted)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: DiscountBadge(
                          discountPercentage:
                              (product as DiscountedProduct)
                                  .discountPercentage,
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              product.category.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          StockBadge(stock: product.stock),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(product.name,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: AppColors.ink)),
                      const SizedBox(height: 8),
                      PriceTag(product: product, large: true),
                      const SizedBox(height: 12),
                      Text(
                        'Stok: ${product.stock} • ${product.getStockStatus()}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.muted),
                      ),
                      const SizedBox(height: 12),
                      Text('Deskripsi',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppColors.ink)),
                      const SizedBox(height: 4),
                      Text(
                        product.description ?? 'Tidak ada deskripsi.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.ink),
                      ),
                      if (isDiscounted) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary),
                          ),
                          child: Text(
                            'Harga normal ${formatRupiah(product.price)} dipotong ${(product as DiscountedProduct).discountPercentage.toStringAsFixed(0)}% jadi ${formatRupiah((product as DiscountedProduct).getDiscountedPrice())}.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.ink),
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      PrimaryButton(
                        label: liked
                            ? 'Hapus dari Favorit'
                            : 'Tambah ke Favorit',
                        icon: liked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        outlined: liked,
                        onPressed:
                            product.stock > 0 || liked
                                ? () => favorites.toggle(product)
                                : null,
                      ),
                      const SizedBox(height: 12),
                      PrimaryButton(
                        label: 'Tambah ke Keranjang',
                        icon: Icons.shopping_cart_outlined,
                        onPressed: product.stock > 0
                            ? () => ScaffoldMessenger.of(context)
                                .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${product.name} masuk keranjang (dummy).'),
                                  ),
                                )
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
