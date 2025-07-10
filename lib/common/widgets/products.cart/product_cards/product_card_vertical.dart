import 'package:ecommerce_store/common/styles/shadow_styles.dart';
import 'package:ecommerce_store/common/widgets/t_rounded_image.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class TProductCardVertical extends StatefulWidget {
  const TProductCardVertical({super.key});

  @override
  State<TProductCardVertical> createState() => _TProductCardVerticalState();
}

class _TProductCardVerticalState extends State<TProductCardVertical> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      width: 180,
      padding: const EdgeInsets.all(TSizes.sm),
      decoration: BoxDecoration(
        boxShadow: [TShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: isDark ? TColors.darkerGrey : TColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Product Image Section
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.productImageRadius),
              color: isDark ? TColors.dark : TColors.light,
            ),
            child: Stack(
              children: [
                // Product Image
                TRoundedImage(
                  imageUrl: TImages.productImage1,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  borderRadius: TSizes.productImageRadius,
                ),

                // Sale Tag (Optional)
                Positioned(
                  top: TSizes.xs,
                  left: TSizes.xs,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.xs,
                      vertical: TSizes.xs / 2,
                    ),
                    decoration: BoxDecoration(
                      color: TColors.secondary,
                      borderRadius: BorderRadius.circular(TSizes.xs),
                    ),
                    child: Text(
                      '25%',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: TColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
// Favorite Icon - FULLY RED HEART ICON WITH RED BACKGROUND
Positioned(
  top: TSizes.xs,
  right: TSizes.xs,
  child: GestureDetector(
    onTap: () {
      setState(() {
        isFavorite = !isFavorite;
      });
    },
    child: Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.red, // Red background
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        Icons.favorite,
        color: isFavorite ? Colors.red.shade700 : Colors.white, // Red heart if active, white if not
        size: TSizes.iconMd,
      ),
    ),
  ),
),

              ],
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwItems / 2),

          // Product Details
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Product Title
                  Text(
                    'Green Nike Air Shoes',
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),

                  const SizedBox(height: TSizes.xs / 2),

                  // Brand Name with Icon
                  Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: TColors.primary,
                        size: TSizes.iconXs,
                      ),
                      const SizedBox(width: TSizes.xs / 2),
                      Expanded(
                        child: Text(
                          'Nike',
                          style: Theme.of(context).textTheme.labelMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  // Price and Add to Cart Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Original Price (if on sale)
                            Text(
                              '\$35.00',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: TColors.darkGrey,
                                  ),
                            ),
                            // Sale Price
                            Text(
                              '\$25.00',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: TColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      // Add to Cart Button
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            // Add to cart logic here
                            debugPrint('Added to cart');
                          },
                          icon: const Icon(
                            Icons.add,
                            color: TColors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ALTERNATIVE: Compact version with red favorite icon
class TProductCardVerticalCompact extends StatefulWidget {
  const TProductCardVerticalCompact({super.key});

  @override
  State<TProductCardVerticalCompact> createState() => _TProductCardVerticalCompactState();
}

class _TProductCardVerticalCompactState extends State<TProductCardVerticalCompact> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      width: 180,
      padding: const EdgeInsets.all(TSizes.sm),
      decoration: BoxDecoration(
        boxShadow: [TShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: isDark ? TColors.darkerGrey : TColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Product Image Section - COMPACT
          Container(
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.productImageRadius),
              color: isDark ? TColors.dark : TColors.light,
            ),
            child: Stack(
              children: [
                // Product Image
                TRoundedImage(
                  imageUrl: TImages.productImage1,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  borderRadius: TSizes.productImageRadius,
                ),

                // Sale Tag (Optional)
                Positioned(
                  top: TSizes.xs,
                  left: TSizes.xs,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.xs / 2,
                      vertical: TSizes.xs / 4,
                    ),
                    decoration: BoxDecoration(
                      color: TColors.secondary,
                      borderRadius: BorderRadius.circular(TSizes.xs / 2),
                    ),
                    child: Text(
                      '25%',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: TColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),

                // Favorite Icon - RED COMPACT
                Positioned(
                  top: TSizes.xs,
                  right: TSizes.xs,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwItems / 2),

          // Product Details - COMPACT
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Product Title
                  Text(
                    'Green Nike Air Shoes',
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),

                  const SizedBox(height: TSizes.xs / 4),

                  // Brand Name with Icon - COMPACT
                  Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: TColors.primary,
                        size: 12,
                      ),
                      const SizedBox(width: TSizes.xs / 4),
                      Expanded(
                        child: Text(
                          'Nike',
                          style: Theme.of(context).textTheme.labelSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  // Price and Add to Cart Button - COMPACT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Original Price (if on sale)
                            Text(
                              '\$35.00',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: TColors.darkGrey,
                                  ),
                            ),
                            // Sale Price
                            Text(
                              '\$25.00',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: TColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      // Add to Cart Button - COMPACT
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            // Add to cart logic here
                            debugPrint('Added to cart');
                          },
                          icon: const Icon(
                            Icons.add,
                            color: TColors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}