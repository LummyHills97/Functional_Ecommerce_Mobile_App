import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';

class TProductCardVertical extends StatelessWidget {
  final Map<String, dynamic> product;

  const TProductCardVertical({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🖼 Product Image Section
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? TColors.dark : TColors.light,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(TSizes.productImageRadius),
                  topRight: Radius.circular(TSizes.productImageRadius),
                ),
              ),
              child: Stack(
                children: [
                  /// Product Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(TSizes.productImageRadius),
                      topRight: Radius.circular(TSizes.productImageRadius),
                    ),
                    child: Image.asset(
                      product['image'],
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// Discount Badge
                  if (product['discount'] != null)
                    Positioned(
                      top: 8,
                      left: 8,
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
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: TColors.white),
                        ),
                      ),
                    ),

                  /// Favourite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      backgroundColor: isDark
                          ? TColors.black.withOpacity(0.6)
                          : TColors.white.withOpacity(0.9),
                      radius: 18,
                      child: IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to wishlist')),
                          );
                        },
                        icon: const Icon(Iconsax.heart, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 📃 Product Details Section - FIXED
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Added this
                children: [
                  /// Product Name & Brand - Made flexible
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          product['name'],
                          style: Theme.of(context).textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: TSizes.xs),
                        Text(
                          product['brand'],
                          style: Theme.of(context).textTheme.labelMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: TSizes.xs), // Small fixed spacing

                  /// Price + Add to Cart - Keep at bottom
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Price Row
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '\$${product['price']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: TColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: TSizes.xs),
                          if (product['originalPrice'] != null)
                            Flexible(
                              child: Text(
                                '\$${product['originalPrice']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: TColors.darkGrey,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: TSizes.xs),

                      /// Add to Cart Button
                      SizedBox(
                        width: double.infinity,
                        height: 36, // Fixed height for button
                        child: Obx(() {
                          final productId = product['id']?.toString() ??
                              product['name'].toString();
                          final isInCart =
                              cartController.isInCart(productId);

                          return ElevatedButton.icon(
                            onPressed: () {
                              cartController.quickAddToCart(
                                productId: productId,
                                productName: product['name'],
                                productPrice: product['price'].toDouble(),
                                productImage: product['image'],
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isInCart
                                  ? Colors.green
                                  : TColors.primary,
                              foregroundColor: TColors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              textStyle: const TextStyle(fontSize: 12),
                              minimumSize: const Size(0, 36),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: Icon(
                              isInCart ? Iconsax.tick_circle : Iconsax.add,
                              size: 16,
                            ),
                            label: Text(
                              isInCart ? 'Added' : 'Add to Cart',
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }),
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