import 'package:ecommerce_store/common/widgets/curved_edges_widget.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? product;
  
  const ProductDetailScreen({
    super.key,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    
    // Use product data if available, otherwise use defaults
    final productName = product?['name'] ?? 'Green Nike Air Shoes';
    final brandName = product?['brand'] ?? 'Nike';
    final price = product?['price'] ?? 25.00;
    final originalPrice = product?['originalPrice'] ?? 35.00;
    final discount = product?['discount'] ?? 25;
    final imageUrl = product?['image'] ?? TImages.productImage1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: dark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: dark ? Colors.white : Colors.black,
            ),
            onPressed: () => debugPrint('Added to favorites: $productName'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Slider
            TCurvedEdgeWidget(
              child: Container(
                color: dark ? TColors.darkerGrey : TColors.light,
                child: Stack(
                  children: [
                    // Main large image
                    Container(
                      height: 300,
                      width: double.infinity,
                      child: Image(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: dark ? Colors.grey[800] : Colors.grey[200],
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 64,
                              color: dark ? Colors.grey[600] : Colors.grey[400],
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Discount badge
                    if (discount > 0)
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '$discount% OFF',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            // Product Details
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name and brand
                  Text(
                    productName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: TSizes.xs),
                  Row(
                    children: [
                      const Icon(Icons.verified, color: TColors.primary, size: 16),
                      const SizedBox(width: TSizes.xs / 2),
                      Text(
                        brandName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: TColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: TSizes.spaceBtwItems),
                  
                  // Price section
                  Row(
                    children: [
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: TColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      if (originalPrice > price)
                        Text(
                          '\$${originalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: TColors.darkGrey,
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: TSizes.spaceBtwSections),
                  
                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Premium quality athletic shoes designed for performance and comfort. Features advanced cushioning technology and durable construction for all-day wear.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: TSizes.spaceBtwSections),
                  
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => debugPrint('Added to cart: $productName'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: TSizes.md),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
                        ),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
