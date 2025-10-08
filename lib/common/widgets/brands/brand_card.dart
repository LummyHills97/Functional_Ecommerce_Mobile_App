import 'package:flutter/material.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    required this.brandName,
    required this.productCount,
    this.onTap,
    this.showBorder = true,
  });

  final String brandName;
  final int productCount;
  final VoidCallback? onTap;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(TSizes.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: showBorder
              ? Border.all(
                  color: isDark ? TColors.darkGrey : TColors.grey,
                )
              : null,
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Brand Icon
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(TSizes.xs),
              decoration: BoxDecoration(
                color: isDark ? TColors.darkGrey : TColors.light,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.storefront,
                size: 24,
                color: TColors.primary,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            
            // Brand Name & Product Count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          brandName,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: TSizes.xs / 2),
                      const Icon(
                        Icons.verified,
                        color: TColors.primary,
                        size: 16,
                      ),
                    ],
                  ),
                  Text(
                    '$productCount Products',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isDark ? TColors.grey : TColors.darkGrey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}