import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/products.cart/product_cards/product_card_horizontal.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatelessWidget {
  final String categoryName;
  
  const SubCategoriesScreen({
    super.key,
    this.categoryName = 'Sports',
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Get products based on category
    final products = _getProductsByCategory(categoryName);
    final bannerConfig = _getBannerConfig(categoryName);

    return Scaffold(
      appBar: TAppBar(
        title: Text(categoryName),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Category Banner
              _buildCategoryBanner(
                context,
                isDark,
                bannerConfig['title']!,
                bannerConfig['subtitle']!,
                bannerConfig['icon'] as IconData,
                bannerConfig['iconColor'] as Color,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Products Section
              Column(
                children: [
                  TSectionHeading(
                    title: '${categoryName} Products',
                    onPressed: () {
                      debugPrint('View all $categoryName products');
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // Products List (Horizontal Cards)
                  products.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              'No products available in this category',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return TProductCardHorizontal(
                              product: product,
                              onAddToCart: () {
                                _showAddToCartDialog(context, product, cartController);
                              },
                            );
                          },
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Get products based on category
  List<Map<String, dynamic>> _getProductsByCategory(String category) {
    final allProducts = {
      'Sports': [
        {
          'id': 'nike_air_jordan_1',
          'name': 'Nike Air Jordan Black Red',
          'brand': 'Nike',
          'image': 'assets/images/products/NikeAirJOrdonBlackRed.png',
          'price': 189.99,
          'originalPrice': 249.99,
          'discount': 24,
        },
        {
          'id': 'nike_air_jordan_2',
          'name': 'Nike Air Jordan Orange',
          'brand': 'Nike',
          'image': 'assets/images/products/NikeAirJOrdonOrange.png',
          'price': 179.99,
          'originalPrice': 239.99,
          'discount': 25,
        },
        {
          'id': 'nike_wildhorse',
          'name': 'Nike Wildhorse Trail',
          'brand': 'Nike',
          'image': 'assets/images/products/NikeWildhorse.png',
          'price': 129.99,
          'originalPrice': 169.99,
          'discount': 24,
        },
        {
          'id': 'adidas_football',
          'name': 'Adidas Football',
          'brand': 'Adidas',
          'image': 'assets/images/products/Adidas_Football.png',
          'price': 45.99,
          'originalPrice': 59.99,
          'discount': 23,
        },
        {
          'id': 'baseball_bat',
          'name': 'Professional Baseball Bat',
          'brand': 'Adidas',
          'image': 'assets/images/products/baseball_bat.png',
          'price': 75.99,
          'originalPrice': 95.99,
          'discount': 21,
        },
        {
          'id': 'tennis_racket',
          'name': 'Tennis Racket Pro',
          'brand': 'Puma',
          'image': 'assets/images/products/tennis_racket.png',
          'price': 89.99,
          'originalPrice': 119.99,
          'discount': 25,
        },
      ],
      'Shoes': [
        {
          'id': 'nike_air_max',
          'name': 'Nike Air Max',
          'brand': 'Nike',
          'image': 'assets/images/products/NikeAirMax.png',
          'price': 149.99,
          'originalPrice': 199.99,
          'discount': 25,
        },
        {
          'id': 'nike_basketball_shoe',
          'name': 'Nike Basketball Shoe Green',
          'brand': 'Nike',
          'image': 'assets/images/products/NikeBasketballShoeGreenBlack.png',
          'price': 139.99,
          'originalPrice': 179.99,
          'discount': 22,
        },
        {
          'id': 'nike_shoes_1',
          'name': 'Nike Sport Shoes',
          'brand': 'Nike',
          'image': 'assets/images/products/nike-shoes.png',
          'price': 119.99,
          'originalPrice': 159.99,
          'discount': 25,
        },
        {
          'id': 'nike_slippers',
          'name': 'Nike Comfort Slippers',
          'brand': 'Nike',
          'image': 'assets/images/products/product-slippers.png',
          'price': 39.99,
          'originalPrice': 54.99,
          'discount': 28,
        },
        {
          'id': 'slipper_1',
          'name': 'Casual Slippers',
          'brand': 'Adidas',
          'image': 'assets/images/products/slipper-product-1.png',
          'price': 34.99,
          'originalPrice': 49.99,
          'discount': 30,
        },
        {
          'id': 'slipper_2',
          'name': 'Sport Slippers',
          'brand': 'Puma',
          'image': 'assets/images/products/slipper-product-2.png',
          'price': 36.99,
          'originalPrice': 49.99,
          'discount': 26,
        },
      ],
      'Electronics': [
        {
          'id': 'iphone_14_pro',
          'name': 'iPhone 14 Pro',
          'brand': 'Apple',
          'image': 'assets/images/products/iphone_14_pro.png',
          'price': 1099.99,
          'originalPrice': 1299.99,
          'discount': 15,
        },
        {
          'id': 'iphone_13_pro',
          'name': 'iPhone 13 Pro',
          'brand': 'Apple',
          'image': 'assets/images/products/iphone_13_pro.png',
          'price': 999.99,
          'originalPrice': 1199.99,
          'discount': 17,
        },
        {
          'id': 'samsung_s9',
          'name': 'Samsung Galaxy S9',
          'brand': 'Samsung',
          'image': 'assets/images/products/samsung_s9_mobile.png',
          'price': 299.99,
          'originalPrice': 399.99,
          'discount': 25,
        },
        {
          'id': 'acer_laptop_1',
          'name': 'Acer Gaming Laptop',
          'brand': 'Acer',
          'image': 'assets/images/products/acer_laptop_1.png',
          'price': 799.99,
          'originalPrice': 999.99,
          'discount': 20,
        },
        {
          'id': 'acer_laptop_2',
          'name': 'Acer Professional Laptop',
          'brand': 'Acer',
          'image': 'assets/images/products/acer_laptop_var_2.png',
          'price': 899.99,
          'originalPrice': 1199.99,
          'discount': 25,
        },
        {
          'id': 'iphone_12_red',
          'name': 'iPhone 12 Red',
          'brand': 'Apple',
          'image': 'assets/images/products/iphone_12_red.png',
          'price': 799.99,
          'originalPrice': 999.99,
          'discount': 20,
        },
      ],
      'Fashion': [
        {
          'id': 'leather_jacket_1',
          'name': 'Premium Leather Jacket',
          'brand': 'H&M',
          'image': 'assets/images/products/leather_jacket_4.png',
          'price': 149.99,
          'originalPrice': 199.99,
          'discount': 25,
        },
        {
          'id': 'blue_shirt_1',
          'name': 'Blue Cotton Shirt',
          'brand': 'Zara',
          'image': 'assets/images/products/product-shirt_blue_2.png',
          'price': 39.99,
          'originalPrice': 59.99,
          'discount': 33,
        },
        {
          'id': 'jeans_1',
          'name': 'Classic Blue Jeans',
          'brand': 'Zara',
          'image': 'assets/images/products/product-jeans.png',
          'price': 79.99,
          'originalPrice': 99.99,
          'discount': 20,
        },
        {
          'id': 'tshirt_blue_1',
          'name': 'Blue T-Shirt',
          'brand': 'H&M',
          'image': 'assets/images/products/tshirt_blue_without_collar_front.png',
          'price': 24.99,
          'originalPrice': 34.99,
          'discount': 29,
        },
        {
          'id': 'tracksuit_blue',
          'name': 'Nike Tracksuit Blue',
          'brand': 'Nike',
          'image': 'assets/images/products/tracksuit_blue.png',
          'price': 89.99,
          'originalPrice': 110.99,
          'discount': 19,
        },
        {
          'id': 'product_jacket',
          'name': 'Sport Jacket',
          'brand': 'Adidas',
          'image': 'assets/images/products/product-jacket.png',
          'price': 95.99,
          'originalPrice': 120.99,
          'discount': 21,
        },
      ],
      'Furniture': [
        {
          'id': 'bedroom_sofa',
          'name': 'Modern Bedroom Sofa',
          'brand': 'IKEA',
          'image': 'assets/images/products/bedroom_sofa.png',
          'price': 299.99,
          'originalPrice': 399.99,
          'discount': 25,
        },
        {
          'id': 'bedroom_bed_black',
          'name': 'Black Bedroom Set',
          'brand': 'IKEA',
          'image': 'assets/images/products/bedroom_bed_black.png',
          'price': 599.99,
          'originalPrice': 799.99,
          'discount': 25,
        },
        {
          'id': 'office_chair_1',
          'name': 'Herman Miller Office Chair',
          'brand': 'Herman Miller',
          'image': 'assets/images/products/office_chair_1.png',
          'price': 799.99,
          'originalPrice': 999.99,
          'discount': 20,
        },
        {
          'id': 'office_desk_1',
          'name': 'Herman Miller Desk',
          'brand': 'Herman Miller',
          'image': 'assets/images/products/office_desk_1.png',
          'price': 699.99,
          'originalPrice': 899.99,
          'discount': 22,
        },
        {
          'id': 'bedroom_lamp',
          'name': 'Modern Bedroom Lamp',
          'brand': 'IKEA',
          'image': 'assets/images/products/bedroom_lamp.png',
          'price': 49.99,
          'originalPrice': 69.99,
          'discount': 29,
        },
        {
          'id': 'dining_table',
          'name': 'Kitchen Dining Table',
          'brand': 'Kenwood',
          'image': 'assets/images/products/kitchen_dining table.png',
          'price': 549.99,
          'originalPrice': 749.99,
          'discount': 27,
        },
      ],
      'Cosmetics': [
        {
          'id': 'cosmetic_placeholder_1',
          'name': 'Premium Face Cream',
          'brand': 'Beauty Co',
          'image': 'assets/images/products/product-1.png',
          'price': 49.99,
          'originalPrice': 69.99,
          'discount': 29,
        },
        {
          'id': 'cosmetic_placeholder_2',
          'name': 'Luxury Perfume Set',
          'brand': 'Fragrance Ltd',
          'image': 'assets/images/products/product-1.png',
          'price': 89.99,
          'originalPrice': 119.99,
          'discount': 25,
        },
      ],
    };

    return allProducts[category] ?? [];
  }

  // Get banner configuration based on category
  Map<String, dynamic> _getBannerConfig(String category) {
    final configs = {
      'Sports': {
        'title': 'SPORTS\nSALE',
        'subtitle': 'Limited time offers',
        'icon': Icons.sports_soccer,
        'iconColor': Color(0xFF00CED1),
      },
      'Shoes': {
        'title': 'SHOES\nCOLLECTION',
        'subtitle': 'Step into style',
        'icon': Icons.sports_basketball,
        'iconColor': Color(0xFFFF6B6B),
      },
      'Electronics': {
        'title': 'TECH\nDEALS',
        'subtitle': 'Latest gadgets',
        'icon': Icons.phone_iphone,
        'iconColor': Color(0xFF4ECDC4),
      },
      'Fashion': {
        'title': 'FASHION\nSALE',
        'subtitle': 'Trendy outfits',
        'icon': Icons.checkroom,
        'iconColor': Color(0xFFFFD700),
      },
      'Furniture': {
        'title': 'FURNITURE\nOFFER',
        'subtitle': 'Home essentials',
        'icon': Icons.chair,
        'iconColor': Color(0xFF95E1D3),
      },
      'Cosmetics': {
        'title': 'BEAUTY\nSALE',
        'subtitle': 'Glow up today',
        'icon': Icons.face,
        'iconColor': Color(0xFFFF9FF3),
      },
    };

    return configs[category] ?? configs['Sports']!;
  }

  Widget _buildCategoryBanner(
    BuildContext context,
    bool isDark,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.md),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2D2D2D),
            const Color(0xFF1A1A1A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(TSizes.md),
              child: CustomPaint(
                painter: _DottedPatternPainter(),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Left side - Text content
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'NEW OFFER',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: TextStyle(
                          color: Color(0xFFFFD700),
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[300],
                              height: 1.2,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFD700),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'SHOP NOW',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Right side - Icon with discount badge
                Expanded(
                  flex: 2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Category icon
                      Transform.rotate(
                        angle: -0.3,
                        child: Icon(
                          icon,
                          size: 75,
                          color: iconColor,
                        ),
                      ),

                      // Discount badge
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFD700),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '50%',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  height: 1,
                                ),
                              ),
                              Text(
                                'OFF',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 7,
                                  fontWeight: FontWeight.w900,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddToCartDialog(
    BuildContext context,
    Map<String, dynamic> product,
    CartController cartController,
  ) {
    String? selectedSize;
    String? selectedColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final sizes = ['S', 'M', 'L', 'XL'];
    final colors = ['Black', 'White', 'Blue', 'Red', 'Green'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: isDark ? TColors.dark : Colors.white,
          title: Text(
            product['name'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : TColors.dark,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      product['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image, size: 50);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "\$${product['price']}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: TColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Select Size:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : TColors.dark,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: sizes.map((size) {
                    final isSelected = selectedSize == size;
                    return ChoiceChip(
                      label: Text(size),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedSize = selected ? size : null;
                        });
                      },
                      selectedColor: TColors.primary,
                      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black),
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Select Color:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : TColors.dark,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: colors.map((color) {
                    final isSelected = selectedColor == color;
                    return ChoiceChip(
                      label: Text(color),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedColor = selected ? color : null;
                        });
                      },
                      selectedColor: TColors.primary,
                      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black),
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: isDark ? Colors.white70 : TColors.dark),
              ),
            ),
            ElevatedButton(
              onPressed: (selectedSize != null && selectedColor != null)
                  ? () {
                      cartController.quickAddToCart(
                        productId: product['id'],
                        productName: product['name'],
                        productPrice: product['price'].toDouble(),
                        productImage: product['image'],
                        productBrand: product['brand'],
                        productSize: selectedSize,
                        productColor: selectedColor,
                      );

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${product['name']} ($selectedColor, $selectedSize) added to cart',
                          ),
                          duration: const Duration(seconds: 2),
                          backgroundColor: TColors.primary,
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for dotted background pattern
class _DottedPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    const spacing = 15.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}