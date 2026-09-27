import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppNetworkImage extends StatelessWidget {
  final String? url;
  final double? height;
  final BoxFit fit;

  const AppNetworkImage({super.key, this.url, this.height, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return Container(
        height: height,
        color: AppColors.line,
        alignment: Alignment.center,
        child: const Icon(Icons.image_not_supported_outlined,
            color: AppColors.muted),
      );
    }
    return Image.network(
      url!,
      height: height,
      width: double.infinity,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          height: height,
          color: AppColors.line,
          alignment: Alignment.center,
          child: const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (context, error, stack) {
        return Container(
          height: height,
          color: AppColors.line,
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image_outlined,
              color: AppColors.muted),
        );
      },
    );
  }
}
