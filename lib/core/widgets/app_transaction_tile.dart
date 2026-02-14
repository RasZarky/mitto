import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mitto/core/theme/app_colors.dart';
import 'package:mitto/core/theme/app_text_style.dart';

class AppTransactionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String? imageUrl;
  final IconData? fallbackIcon;
  final VoidCallback? onTap;

  const AppTransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.imageUrl,
    this.fallbackIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 88,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0x1AFFFFFF),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.gray700,
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.basicWhite,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => _buildFallbackIcon(),
                    )
                  : _buildFallbackIcon(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.baseMedium.copyWith(color: AppColors.basicWhite),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyle.xsRegular.copyWith(color: AppColors.gray400),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: AppTextStyle.baseSemibold.copyWith(color: title == 'Transfer In' ?
              AppColors.accentGreen : AppColors.basicWhite),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackIcon() {
    return Container(
      width: 56,
      height: 56,
      color: AppColors.gray700,
      child: Icon(
        fallbackIcon ?? Icons.shopping_bag_outlined,
        color: AppColors.basicWhite,
      ),
    );
  }
}
