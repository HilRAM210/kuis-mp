import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class StockBadge extends StatelessWidget {
  final int stock;

  const StockBadge({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final inStock = stock > 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: inStock ? AppColors.primaryContainer : const Color(0xFFFDECEA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        inStock ? 'In Stock ($stock)' : 'Out of Stock',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: inStock ? AppColors.primary : AppColors.danger,
            ),
      ),
    );
  }
}
