import 'package:flutter/material.dart';

import '../../features/products/models/discounted_product.dart';
import '../../features/products/models/product.dart';
import '../theme/app_colors.dart';
import 'app_network_image.dart';
import 'discount_badge.dart';
import 'favorite_button.dart';
import 'price_tag.dart';
import 'stock_badge.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onTap,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                AppNetworkImage(url: product.imageUrl, height: 120),
                if (product is DiscountedProduct &&
                    (product as DiscountedProduct).discountPercentage > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: DiscountBadge(
                      discountPercentage:
                          (product as DiscountedProduct).discountPercentage,
                    ),
                  ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: FavoriteButton(
                    isFavorite: isFavorite,
                    onPressed: onToggleFavorite,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 14,
                            height: 1.2,
                            color: AppColors.ink,
                          ),
                    ),
                    const SizedBox(height: 6),
                    PriceTag(product: product),
                    const SizedBox(height: 6),
                    StockBadge(stock: product.stock),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
