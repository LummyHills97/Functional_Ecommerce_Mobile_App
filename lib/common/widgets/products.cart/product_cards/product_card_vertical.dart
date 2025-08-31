import 'package:ecommerce_store/common/styles/shadow_styles.dart';
import 'package:ecommerce_store/common/widgets/t_rounded_image.dart';
import 'package:ecommerce_store/features/shop/screens/product_details/widgets/product_detail.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class TProductCardVertical extends StatefulWidget {
  final Map<String, dynamic>? product; // Add product parameter
  
  const TProductCardVertical({
    super.key,
    this.product,
  });

  @override
  State<TProductCardVertical> createState() => _TProductCardVerticalState();
}

class _TProductCardVerticalState extends State<TProductCardVertical> {
  bool isFavorited = false;

  void _navigateToProductDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(product: widget.product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    
    // Use product data if available, otherwise use default values
    final productName = widget.product?['name'] ?? 'Green Nike Air Shoes';
    final brandName = widget.product?['brand'] ?? 'Nike';
    final price = widget.product?['price'] ?? 25.00;
    final originalPrice = widget.product?['originalPrice'] ?? 35.00;
    final discount = widget.product?['discount'] ?? 25;
    final imageUrl = widget.product?['image'] ?? TImages.productImage1;

    return GestureDetector(
      onTap: () => _navigateToProductDetails(context),
      child: Container(
        padding: const EdgeInsets.all(TSizes.sm),
        decoration: BoxDecoration(
          boxShadow: isDark ? [] : const [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: isDark ? Colors.black : TColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE SECTION
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TSizes.productImageRadius),
                color: isDark ? Colors.black : TColors.light,
              ),
              child: Stack(
                children: [
                  TRoundedImage(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    borderRadius: TSizes.productImageRadius,
                  ),

                  /// Discount Label
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
                        '$discount%',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: TColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),

                  /// Favorite Button
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

            /// DETAILS SECTION
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Product Name
                    Flexible(
                      child: Text(
                        productName,
                        style: Theme.of(context).textTheme.labelLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),

                    const SizedBox(height: TSizes.xs / 2),

                    /// Brand Row
                    Row(
                      children: [
                        const Icon(Icons.verified,
                            color: TColors.primary, size: TSizes.iconXs),
                        const SizedBox(width: TSizes.xs / 2),
                        Flexible(
                          child: Text(
                            brandName,
                            style: Theme.of(context).textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    /// Price + Add to Cart
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${originalPrice.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: TColors.darkGrey,
                                    ),
                              ),
                              Text(
                                '\$${price.toStringAsFixed(2)}',
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

                        /// Add to Cart Button
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white10 : TColors.dark,
                            borderRadius:
                                BorderRadius.circular(TSizes.cardRadiusSm),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () =>
                                debugPrint('Added to cart: $productName'),
                            icon: const Icon(Icons.add,
                                color: TColors.white, size: 20),
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
      ),
    );
  }
}
