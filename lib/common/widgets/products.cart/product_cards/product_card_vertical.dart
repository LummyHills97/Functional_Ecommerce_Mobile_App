import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce_store/common/widgets/animated_cart_button.dart'; // Add this import
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
          // Image Container
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
                  // Product Image
                  Center(
                    child: ClipRRect(
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
                  ),
                  
                  // Discount Badge
                  if (product['discount'] != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: TColors.secondary.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(TSizes.sm),
                        ),
                        child: Text(
                          '${product['discount']}%',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: TColors.white,
                          ),
                        ),
                      ),
                    ),
                  
                  // Favourite Icon
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? TColors.black.withOpacity(0.6) : TColors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Add to wishlist functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to wishlist')),
                          );
                        },
                        icon: const Icon(
                          Iconsax.heart,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Product Details
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        product['name'],
                        style: Theme.of(context).textTheme.labelLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      
                      const SizedBox(height: TSizes.xs),
                      
                      // Brand Name
                      Text(
                        product['brand'],
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  
                  // Price and Add to Cart
                  Column(
                    children: [
                      // Price Row
                      Row(
                        children: [
                          // Current Price
                          Text(
                            '\$${product['price']}',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: TColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          
                          const SizedBox(width: TSizes.xs),
                          
                          // Original Price (if exists)
                          if (product['originalPrice'] != null)
                            Text(
                              '\$${product['originalPrice']}',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: TColors.darkGrey,
                              ),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: TSizes.xs),
                      
                      // Add to Cart Button with Animation
                      AnimatedCartButton(
                        productId: product['id']?.toString() ?? product['name'].toString(),
                        productName: product['name'],
                        productPrice: product['price'].toDouble(),
                        productImage: product['image'],
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