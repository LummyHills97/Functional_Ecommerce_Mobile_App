import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/navigation_menu.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  // Mock wishlist data - replace with your actual data source
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
    {
      'id': 3,
      'name': 'Blue Denim Jacket',
      'brand': 'Levi\'s',
      'price': 89.99,
      'originalPrice': 119.99,
      'discount': 25,
      'image': 'assets/images/products/product-jacket.png',
      'isFavorite': true,
    },
    {
      'id': 4,
      'name': 'Acer Laptop Pro',
      'brand': 'Acer',
      'price': 599.99,
      'originalPrice': 799.99,
      'discount': 25,
      'image': 'assets/images/products/acer_laptop_1.png',
      'isFavorite': true,
    },
  ];

  void _removeFromWishlist(int index) {
    setState(() {
      wishlistItems.removeAt(index);
    });
    
    // Show snackbar for feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item removed from wishlist'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Add undo functionality if needed
          },
        ),
      ),
    );
  }

  void _toggleFavorite(int index) {
    setState(() {
      wishlistItems[index]['isFavorite'] = !wishlistItems[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Theme.of(context).scaffoldBackgroundColor,
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Shopping bag icon to go to store
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Iconsax.shopping_bag,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  Get.offAll(() => const NavigationMenu(initialIndex: 1)); // Go to store tab
                },
                tooltip: 'Go to Store',
              ),
            ),
          ),
          // Add more items icon
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Iconsax.add,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  Get.offAll(() => const NavigationMenu(initialIndex: 0)); // Go to home
                },
                tooltip: 'Add More Items',
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: wishlistItems.isEmpty 
            ? _buildEmptyWishlist(context, isDarkMode)
            : Column(
                children: [
                  // Wishlist count header
                  Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${wishlistItems.length} item${wishlistItems.length != 1 ? 's' : ''} in wishlist',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            // Clear all wishlist
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Clear Wishlist'),
                                content: const Text('Are you sure you want to remove all items from your wishlist?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        wishlistItems.clear();
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Clear All'),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(
                            Iconsax.trash,
                            size: 16,
                            color: Colors.red[400],
                          ),
                          label: Text(
                            'Clear All',
                            style: TextStyle(color: Colors.red[400]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Wishlist grid
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                      child: TGridLayout(
                        itemCount: wishlistItems.length,
                        itemBuilder: (_, index) => _buildWishlistCard(
                          context, 
                          wishlistItems[index], 
                          index, 
                          isDarkMode
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildEmptyWishlist(BuildContext context, bool isDarkMode) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty wishlist icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.heart,
                size: 60,
                color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            
            Text(
              'Your Wishlist is Empty',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            
            Text(
              'Save items you love by tapping the heart icon.\nStart exploring and add products to your wishlist!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            
            // Start shopping button
            ElevatedButton.icon(
              onPressed: () {
                Get.offAll(() => const NavigationMenu(initialIndex: 0));
              },
              icon: const Icon(Iconsax.shopping_bag),
              label: const Text('Start Shopping'),
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistCard(BuildContext context, Map<String, dynamic> item, int index, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode 
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image - Reduced flex
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      item['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.image_not_supported_outlined,
                          size: 48,
                          color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                        );
                      },
                    ),
                  ),
                ),
              ),
              
              // Product Details - Increased flex and reduced padding
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Product name - Reduced to 1 line
                      Text(
                        item['name'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      
                      // Brand
                      Text(
                        item['brand'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Price row
                      Row(
                        children: [
                          Text(
                            '\$${item['price']}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: TColors.primary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          if (item['originalPrice'] != null)
                            Flexible(
                              child: Text(
                                '\$${item['originalPrice']}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: isDarkMode ? Colors.grey[500] : Colors.grey[500],
                                  decoration: TextDecoration.lineThrough,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: 6),
                      
                      // Add to cart button - Reduced height
                      SizedBox(
                        width: double.infinity,
                        height: 28,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add to cart functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${item['name']} added to cart'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Discount badge
          if (item['discount'] != null && item['discount'] > 0)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${item['discount']}% OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          
          // Favorite button - Interactive and always filled since it's in wishlist
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isDarkMode 
                    ? Colors.black.withOpacity(0.7)
                    : Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _removeFromWishlist(index),
                  child: Icon(
                    item['isFavorite'] ? Iconsax.heart5 : Iconsax.heart,
                    size: 18,
                    color: item['isFavorite'] ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TGridLayout extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  
  const TGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.65, // Fine-tuned to eliminate final overflow
      ),
      itemBuilder: itemBuilder,
    );
  }
}