import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/formaters/currency_formatter.dart';
import '../../features/products/models/discounted_product.dart';
import '../../features/products/models/product.dart';

class PriceTag extends StatelessWidget {
  final Product product;
  final bool large;

  const PriceTag({super.key, required this.product, this.large = false});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    if (product is DiscountedProduct) {
      final d = product as DiscountedProduct;
      if (d.discountPercentage > 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              formatRupiah(product.price),
              style: style.bodyMedium?.copyWith(
                color: AppColors.muted,
                decoration: TextDecoration.lineThrough,
                fontSize: large ? 13 : 12,
              ),
            ),
            Text(
              formatRupiah(d.getDiscountedPrice()),
              style: (large ? style.titleMedium : style.bodyLarge)?.copyWith(
                color: AppColors.danger,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      }
    }
    return Text(
      formatRupiah(product.price),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: (large ? style.titleMedium : style.bodyLarge)?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.ink,
      ),
    );
  }
}
