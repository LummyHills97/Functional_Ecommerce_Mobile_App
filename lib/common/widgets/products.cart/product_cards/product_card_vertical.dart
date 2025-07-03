import 'package:ecommerce_store/common/styles/shadow_styles.dart';
import 'package:ecommerce_store/common/widgets/t_rounded_image.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

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
        children: [
          // Product Image Section
          Container(
            height: 180,
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

                // Favorite Icon
                Positioned(
                  top: TSizes.xs,
                  right: TSizes.xs,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? TColors.black.withOpacity(0.9)
                          : TColors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(TSizes.lg),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        color: isDark ? TColors.white : TColors.dark,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Title
                Text(
                  'Green Nike Air Shoes',
                  style: Theme.of(context).textTheme.labelLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),

                const SizedBox(height: TSizes.xs),

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
                      decoration: BoxDecoration(
                        color: TColors.dark,
                        borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: TColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
