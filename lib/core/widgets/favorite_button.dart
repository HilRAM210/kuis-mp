import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.9),
      shape: const CircleBorder(),
      elevation: 1,
      child: IconButton(
        tooltip: isFavorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? AppColors.danger : AppColors.muted,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
