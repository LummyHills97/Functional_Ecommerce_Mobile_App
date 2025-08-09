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
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      width: 180,
      padding: const EdgeInsets.all(TSizes.sm),
      decoration: BoxDecoration(
        boxShadow: isDark ? [] : const [TShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: isDark ? Colors.black : TColors.white,
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
              color: isDark ? Colors.black : TColors.light,
            ),
            child: Stack(
              children: [
                // Product Image
                const TRoundedImage(
                  imageUrl: TImages.productImage1,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  borderRadius: TSizes.productImageRadius,
                ),

                // Sale Tag
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

                // Favorite Icon Toggle
                Positioned(
                  top: TSizes.xs,
                  right: TSizes.xs,
                  child: IconButton(
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorited = !isFavorited;
                      });
                    },
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
                  Text(
                    'Green Nike Air Shoes',
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: TSizes.xs / 2),
                  Row(
                    children: [
                      const Icon(Icons.verified, color: TColors.primary, size: TSizes.iconXs),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$35.00',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: TColors.darkGrey,
                                  ),
                            ),
                            Text(
                              '\$25.00',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: TColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : TColors.dark,
                          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => debugPrint('Added to cart'),
                          icon: const Icon(Icons.add, color: TColors.white, size: 20),
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
