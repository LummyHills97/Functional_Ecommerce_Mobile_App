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

  Widget _buildWishlistCard(
      BuildContext context, Map<String, dynamic> item, int index, bool isDark) {
    final CartController cartController = Get.find<CartController>();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(item['image'], fit: BoxFit.cover),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(item['brand'],
                          style: Theme.of(context).textTheme.bodySmall),
                      Row(
                        children: [
                          Text('\$${item['price']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: TColors.primary)),
                          if (item['originalPrice'] != null)
                            Text('\$${item['originalPrice']}',
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough)),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
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
                          ),
                          child: Obx(() => Text(
                                cartController.isInCart(item['id'].toString())
                                    ? 'Added ✓'
                                    : 'Add to Cart',
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: () => _removeFromWishlist(index),
              icon: const Icon(Iconsax.heart5, color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: wishlistItems.length,
        itemBuilder: (ctx, i) =>
            _buildWishlistCard(ctx, wishlistItems[i], i, isDark),
      ),
    );
  }
}
