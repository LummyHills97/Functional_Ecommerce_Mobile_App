import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  final Map<String, dynamic> product;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: 120, // ✅ Fixed height to prevent overflow
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: isDark ? TColors.darkerGrey : TColors.lightContainer,
      ),
      child: Row(
        children: [
          // Image Section
          Container(
            height: 120,
            width: 120,
            padding: const EdgeInsets.all(TSizes.sm),
            decoration: BoxDecoration(
              color: isDark ? TColors.dark : TColors.light,
              borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            ),
            child: Stack(
              children: [
                // Product Image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(TSizes.productImageRadius),
                    child: Image.asset(
                      product['image'],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.image,
                          size: 50,
                          color: isDark ? Colors.white54 : Colors.black54,
                        );
                      },
                    ),
                  ),
                ),

                // Discount Badge
                if (product['discount'] != null && product['discount'] > 0)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: TColors.secondary.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(TSizes.sm),
                      ),
                      child: Text(
                        '${product['discount']}%',
                        style: Theme.of(context).textTheme.labelSmall!.apply(
                              color: TColors.black,
                              fontSizeFactor: 0.9,
                            ),
                      ),
                    ),
                  ),

                // Favorite Icon
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? TColors.black.withOpacity(0.9)
                          : Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Handle favorite action
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 18,
                      ),
                      color: Colors.red,
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product Details Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.sm,
                vertical: TSizes.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Product Name and Brand
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Brand
                        Text(
                          product['brand'] ?? '',
                          style: Theme.of(context).textTheme.labelSmall!.apply(
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),

                        // Product Name
                        Text(
                          product['name'] ?? '',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Price and Add to Cart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Price
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (product['originalPrice'] != null)
                              Text(
                                '\$${product['originalPrice']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .apply(
                                      decoration: TextDecoration.lineThrough,
                                      color: isDark
                                          ? Colors.white54
                                          : Colors.black54,
                                    ),
                              ),
                            Text(
                              '\$${product['price']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .apply(
                                    color: TColors.primary,
                                    fontWeightDelta: 2,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      // Add to Cart Button
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomRight:
                                Radius.circular(TSizes.productImageRadius),
                          ),
                        ),
                        child: SizedBox(
                          width: TSizes.iconLg * 1.2,
                          height: TSizes.iconLg * 1.2,
                          child: IconButton(
                            onPressed: onAddToCart,
                            icon: const Icon(
                              Icons.add,
                              color: TColors.white,
                              size: 20,
                            ),
                            padding: EdgeInsets.zero,
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