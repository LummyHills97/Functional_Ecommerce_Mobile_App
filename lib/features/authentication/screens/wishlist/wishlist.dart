import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final CartController cartController = Get.put(CartController());

  final List<Map<String, dynamic>> wishlistItems = [
    {
      'id': 1,
      'name': 'Nike Air Max Pro',
      'brand': 'Nike',
      'price': 129.99,
      'originalPrice': 159.99,
      'discount': 19,
      'image': 'assets/images/products/nike-shoes.png',
      'isFavorite': true,
    },
    {
      'id': 2,
      'name': 'Samsung Galaxy S9',
      'brand': 'Samsung',
      'price': 299.99,
      'originalPrice': 399.99,
      'discount': 25,
      'image': 'assets/images/products/samsung_s9_mobile.png',
      'isFavorite': true,
    },
  ];

  void _removeFromWishlist(int index) {
    setState(() {
      wishlistItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item removed from wishlist')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wishlist"),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.trash),
            onPressed: () {
              setState(() {
                wishlistItems.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Wishlist cleared')),
              );
            },
          ),
        ],
      ),
      body: wishlistItems.isEmpty
          ? const Center(child: Text("Your wishlist is empty"))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: wishlistItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65, // Changed from 0.75 to 0.65 for more height
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return _buildWishlistCard(
                  context,
                  wishlistItems[index],
                  index,
                  isDark,
                );
              },
            ),
    );
  }

  Widget _buildWishlistCard(
      BuildContext context, Map<String, dynamic> item, int index, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
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
        children: [
          // Image section - Fixed height
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Container(
                    width: double.infinity,
                    child: Image.asset(
                      item['image'], 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Heart icon positioned on top-right of image
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => _removeFromWishlist(index),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Iconsax.heart5, 
                        color: Colors.red, 
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content section
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name - limit to 2 lines
                  Text(
                    item['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: 2),
                  
                  // Brand
                  Text(
                    item['brand'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Price section
                  Row(
                    children: [
                      Text(
                        '\$${item['price']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: TColors.primary,
                          fontSize: 14,
                        ),
                      ),
                      if (item['originalPrice'] != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          '\$${item['originalPrice']}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Add to cart button
                  SizedBox(
                    width: double.infinity,
                    height: 32, // Fixed height for button
                    child: Obx(() => ElevatedButton(
                          onPressed: () {
                            cartController.quickAddToCart(
                              productId: item['id'].toString(),
                              productName: item['name'],
                              productPrice: item['price'],
                              productImage: item['image'],
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                cartController.isInCart(item['id'].toString())
                                    ? Colors.green
                                    : TColors.primary,
                            padding: EdgeInsets.zero,
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                          child: Text(
                            cartController.isInCart(item['id'].toString())
                                ? 'Added ✓'
                                : 'Add to Cart',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        )),
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