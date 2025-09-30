import 'package:ecommerce_store/features/authentication/screens/wishlist/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_store/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? TColors.white : TColors.dark,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                color: isDark ? TColors.white : TColors.dark,
              ),
            ),
            TCartCounterIcon(
              onPressed: () => Get.toNamed('/cart'),
              iconColor: isDark ? TColors.white : TColors.dark,
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: TSearchContainer(text: 'Search in Store'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: TSectionHeading(
                      title: 'Featured Brands',
                      showActionButton: true,
                      buttonTitle: 'View all',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  isScrollable: true,
                  indicatorColor: TColors.primary,
                  labelColor: TColors.primary,
                  unselectedLabelColor: isDark ? TColors.grey : TColors.darkerGrey,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(text: 'Sport'),
                    Tab(text: 'Furniture'),
                    Tab(text: 'Electronics'),
                    Tab(text: 'Clothes'),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _buildBrandColumn(context, isDark, 'sport'),
              _buildBrandColumn(context, isDark, 'furniture'),
              _buildBrandColumn(context, isDark, 'electronics'),
              _buildBrandColumn(context, isDark, 'clothes'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandColumn(BuildContext context, bool isDark, String category) {
    final CartController cartController = Get.find<CartController>();
    final WishlistController wishlistController = Get.find<WishlistController>();

    final brandMap = {
      'sport': ['Nike', 'Adidas'],
      'furniture': ['IKEA', 'Ashley'],
      'electronics': ['Samsung', 'Acer'],
      'clothes': ['Zara', 'H&M'],
    };

    final brandImages = {
      'Nike': [
        'assets/images/products/NikeAirMax.png',
        'assets/images/products/nike-shoes.png',
        'assets/images/products/tracksuit_blue.png',
      ],
      'Adidas': [
        'assets/images/products/Adidas_Football.png',
        'assets/images/products/baseball_bat.png',
        'assets/images/products/product-jacket.png',
      ],
      'IKEA': [
        'assets/images/products/bedroom_sofa.png',
        'assets/images/products/bedroom_bed_black.png',
        'assets/images/products/bedroom_lamp.png',
      ],
      'Ashley': [
        'assets/images/products/bedroom_lamp.png',
        'assets/images/products/bedroom_sofa.png',
        'assets/images/products/bedroom_bed_black.png',
      ],
      'Samsung': [
        'assets/images/products/samsung_s9_mobile.png',
        'assets/images/products/samsung_s9_mobile_withback.png',
        'assets/images/products/samsung_s9_mobile.png',
      ],
      'Acer': [
        'assets/images/products/acer_laptop_1.png',
        'assets/images/products/acer_laptop_var_2.png',
        'assets/images/products/acer_laptop_3.png',
      ],
      'Zara': [
        'assets/images/products/product-shirt_blue_2.png',
        'assets/images/products/product-jeans.png',
        'assets/images/products/product-shirt.png',
      ],
      'H&M': [
        'assets/images/products/leather_jacket_4.png',
        'assets/images/products/tshirt_blue_without_collar_front.png',
        'assets/images/products/tshirt_yellow_collar.png',
      ],
    };

    final categoryProducts = {
      'sport': [
        {
          'id': 'sport_nike_airmax_1',
          'name': 'Nike Air Max Pro',
          'brand': 'Nike',
          'price': 120.99,
          'originalPrice': 150.99,
          'discount': 20,
          'image': 'assets/images/products/nike-shoes.png',
        },
        {
          'id': 'sport_adidas_football_1',
          'name': 'Adidas Football',
          'brand': 'Adidas',
          'price': 45.99,
          'originalPrice': 55.99,
          'discount': 18,
          'image': 'assets/images/products/Adidas_Football.png',
        },
        {
          'id': 'sport_nike_tracksuit_1',
          'name': 'Nike Tracksuit Blue',
          'brand': 'Nike',
          'price': 89.99,
          'originalPrice': 110.99,
          'discount': 19,
          'image': 'assets/images/products/tracksuit_blue.png',
        },
        {
          'id': 'sport_baseball_bat_1',
          'name': 'Professional Baseball Bat',
          'brand': 'Adidas',
          'price': 75.99,
          'originalPrice': 95.99,
          'discount': 21,
          'image': 'assets/images/products/baseball_bat.png',
        },
      ],
      'furniture': [
        {
          'id': 'furniture_sofa_1',
          'name': 'Modern Bedroom Sofa',
          'brand': 'IKEA',
          'price': 299.99,
          'originalPrice': 399.99,
          'discount': 25,
          'image': 'assets/images/products/bedroom_sofa.png',
        },
        {
          'id': 'furniture_bed_1',
          'name': 'Black Bedroom Set',
          'brand': 'Ashley',
          'price': 599.99,
          'originalPrice': 799.99,
          'discount': 25,
          'image': 'assets/images/products/bedroom_bed_black.png',
        },
        {
          'id': 'furniture_lamp_1',
          'name': 'Modern Bedroom Lamp',
          'brand': 'IKEA',
          'price': 49.99,
          'originalPrice': 69.99,
          'discount': 29,
          'image': 'assets/images/products/bedroom_lamp.png',
        },
        {
          'id': 'furniture_lamp_2',
          'name': 'Designer Table Lamp',
          'brand': 'Ashley',
          'price': 79.99,
          'originalPrice': 99.99,
          'discount': 20,
          'image': 'assets/images/products/bedroom_lamp.png',
        },
      ],
      'electronics': [
        {
          'id': 'electronics_samsung_s9_1',
          'name': 'Samsung Galaxy S9',
          'brand': 'Samsung',
          'price': 299.99,
          'originalPrice': 399.99,
          'discount': 25,
          'image': 'assets/images/products/samsung_s9_mobile.png',
        },
        {
          'id': 'electronics_acer_laptop_1',
          'name': 'Acer Gaming Laptop',
          'brand': 'Acer',
          'price': 799.99,
          'originalPrice': 999.99,
          'discount': 20,
          'image': 'assets/images/products/acer_laptop_1.png',
        },
        {
          'id': 'electronics_samsung_s9_back_1',
          'name': 'Samsung S9 Special Edition',
          'brand': 'Samsung',
          'price': 349.99,
          'originalPrice': 449.99,
          'discount': 22,
          'image': 'assets/images/products/samsung_s9_mobile_withback.png',
        },
        {
          'id': 'electronics_acer_laptop_2',
          'name': 'Acer Professional Laptop',
          'brand': 'Acer',
          'price': 899.99,
          'originalPrice': 1199.99,
          'discount': 25,
          'image': 'assets/images/products/acer_laptop_var_2.png',
        },
      ],
      'clothes': [
        {
          'id': 'clothes_blue_shirt_1',
          'name': 'Blue Cotton Shirt',
          'brand': 'Zara',
          'price': 39.99,
          'originalPrice': 59.99,
          'discount': 33,
          'image': 'assets/images/products/product-shirt_blue_2.png',
        },
        {
          'id': 'clothes_leather_jacket_1',
          'name': 'Premium Leather Jacket',
          'brand': 'H&M',
          'price': 149.99,
          'originalPrice': 199.99,
          'discount': 25,
          'image': 'assets/images/products/leather_jacket_4.png',
        },
        {
          'id': 'clothes_jeans_1',
          'name': 'Classic Blue Jeans',
          'brand': 'Zara',
          'price': 79.99,
          'originalPrice': 99.99,
          'discount': 20,
          'image': 'assets/images/products/product-jeans.png',
        },
        {
          'id': 'clothes_tshirt_blue_1',
          'name': 'Blue T-Shirt',
          'brand': 'H&M',
          'price': 24.99,
          'originalPrice': 34.99,
          'discount': 29,
          'image': 'assets/images/products/tshirt_blue_without_collar_front.png',
        },
      ],
    };

    final brands = brandMap[category] ?? [];
    final products = categoryProducts[category] ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: brands.map((name) {
              final images = brandImages[name] ?? [];
              final index = brands.indexOf(name);
              return Padding(
                padding: const EdgeInsets.only(bottom: TSizes.defaultSpace),
                child: _buildBrandCard(context, name, index, isDark, images),
              );
            }).toList(),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          
          TSectionHeading(
            title: 'More Products',
            showActionButton: true,
            buttonTitle: 'View all',
            onPressed: () {},
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          
          GridView.builder(
            itemCount: products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: TSizes.gridViewSpacing,
              crossAxisSpacing: TSizes.gridViewSpacing,
              mainAxisExtent: 280,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(context, product, isDark, cartController, wishlistController);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context, 
    Map<String, dynamic> product, 
    bool isDark,
    CartController cartController,
    WishlistController wishlistController
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        boxShadow: [
          BoxShadow(
            color: isDark 
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
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(TSizes.productImageRadius),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(TSizes.productImageRadius),
                  ),
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.shopping_bag_outlined,
                        size: 48,
                        color: isDark ? Colors.grey[600] : Colors.grey[400],
                      );
                    },
                  ),
                ),
              ),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product['name'],
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      
                      Text(
                        product['brand'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 4),
                      
                      Row(
                        children: [
                          Text(
                            "\$${product['price']}",
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: TColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 4),
                          if (product['originalPrice'] != null)
                            Flexible(
                              child: Text(
                                "\$${product['originalPrice']}",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 10,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: 6),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 28,
                        child: ElevatedButton(
                          onPressed: () {
                            _showAddToCartDialog(context, product, cartController);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          if (product['discount'] > 0)
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
                  '${product['discount']}% OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          
          Positioned(
            top: 8,
            right: 8,
            child: Obx(() => Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isDark 
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
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    wishlistController.toggleWishlist(product);
                  },
                  child: Icon(
                    wishlistController.isInWishlist(product['id'])
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 16,
                    color: wishlistController.isInWishlist(product['id'])
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),
              ),
            )),
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
    
    final sizes = ['S', 'M', 'L', 'XL'];
    final colors = ['Black', 'White', 'Blue', 'Red', 'Green'];
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            product['name'],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      product['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                Text(
                  '\$${product['price']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: TColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                
                const Text(
                  'Select Size:',
                  style: TextStyle(fontWeight: FontWeight.w600),
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
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                
                const Text(
                  'Select Color:',
                  style: TextStyle(fontWeight: FontWeight.w600),
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
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
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
              child: const Text('Cancel'),
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
                            '${product['name']} ($selectedColor, $selectedSize) added to cart'
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

  Widget _buildBrandCard(BuildContext context, String name, int index, bool isDark, List<String> images) {
    return Container(
      padding: const EdgeInsets.all(TSizes.sm),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: isDark ? TColors.darkGrey : TColors.grey,
        ),
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withOpacity(0.2)
                : Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(TSizes.xs),
                decoration: BoxDecoration(
                  color: isDark ? TColors.darkGrey : TColors.light,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.storefront,
                  size: 20,
                  color: TColors.primary,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: TSizes.xs / 2),
                        const Icon(
                          Icons.verified,
                          color: TColors.primary,
                          size: 14,
                        ),
                      ],
                    ),
                    Text(
                      '${(index + 1) * 25} Products',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: isDark ? TColors.grey : TColors.darkGrey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (images.isNotEmpty) ...[
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                separatorBuilder: (context, index) => const SizedBox(width: TSizes.sm),
                itemBuilder: (context, index) {
                  return Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isDark ? Colors.grey[800] : TColors.light,
                      border: Border.all(
                        color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                        width: 0.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image_not_supported_outlined,
                            color: isDark ? Colors.grey[600] : Colors.grey[400],
                            size: 24,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) => false;
}