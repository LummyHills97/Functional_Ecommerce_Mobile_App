import 'package:ecommerce_store/features/authentication/screens/wishlist/wishlist_controller.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final WishlistController wishlistController = Get.find<WishlistController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("My Wishlist (${wishlistController.wishlistCount})")),
        actions: [
          Obx(() => wishlistController.wishlistItems.isNotEmpty
              ? IconButton(
                  icon: const Icon(Iconsax.trash),
                  onPressed: () {
                    // Show confirmation dialog
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Clear Wishlist'),
                        content: const Text('Are you sure you want to remove all items?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              wishlistController.clearWishlist();
                              Get.back();
                            },
                            child: const Text('Clear All'),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() => wishlistController.wishlistItems.isEmpty
          ? _buildEmptyWishlist()
          : _buildWishlistGrid(cartController, wishlistController, isDark)),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.heart,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Your wishlist is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items you love to see them here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.shopping_bag),
            label: const Text('Start Shopping'),
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistGrid(CartController cartController, WishlistController wishlistController, bool isDark) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: wishlistController.wishlistItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final item = wishlistController.wishlistItems[index];
        return _buildWishlistCard(context, item, index, isDark, cartController, wishlistController);
      },
    );
  }

  Widget _buildWishlistCard(
      BuildContext context, 
      Map<String, dynamic> item, 
      int index, 
      bool isDark,
      CartController cartController,
      WishlistController wishlistController) {
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
          // Image section
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Container(
                    width: double.infinity,
                    child: Image.asset(
                      item['image'], 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Heart icon to remove from wishlist
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => wishlistController.removeByIndex(index),
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
                  // Product name
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
                  // Add to cart button (always consistent)
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {
                       cartController.quickAddToCart(
  productId: item['id'].toString(),
  productName: item['name'],
  productPrice: item['price'].toDouble(),
  productImage: item['image'],
  productBrand: item['brand'] ?? 'Unknown Brand',  // ✅ Add this line
  productSize: null,  // ✅ Add this if you want to allow adding without size
  productColor: null, // ✅ Add this if you want to allow adding without color
);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary,
                        padding: EdgeInsets.zero,
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
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