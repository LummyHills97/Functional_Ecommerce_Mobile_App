import 'package:flutter/material.dart';
import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_store/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
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
              onPressed: () {},
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

    final brands = brandMap[category] ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Brands Section
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
          
          // More Products Section
          TSectionHeading(
            title: 'More Products',
            showActionButton: true,
            buttonTitle: 'View all',
            onPressed: () {},
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          
          // Properly aligned grid with dark mode support
          GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: TSizes.gridViewSpacing,
              crossAxisSpacing: TSizes.gridViewSpacing,
              mainAxisExtent: 260, // Increased height for better proportions
            ),
            itemBuilder: (context, index) {
              final sampleProducts = [
                {
                  'name': 'Nike Air Max',
                  'price': 15000,
                  'originalPrice': 20000,
                  'discount': 25,
                  'image': 'assets/images/products/nike-shoes.png',
                },
                {
                  'name': 'Samsung Galaxy S9',
                  'price': 30000,
                  'originalPrice': 35000,
                  'discount': 14,
                  'image': 'assets/images/products/samsung_s9_mobile.png',
                },
                {
                  'name': 'Acer Laptop',
                  'price': 45000,
                  'originalPrice': 50000,
                  'discount': 10,
                  'image': 'assets/images/products/acer_laptop_2.png',
                },
                {
                  'name': 'Blue Shirt',
                  'price': 60000,
                  'originalPrice': 75000,
                  'discount': 20,
                  'image': 'assets/images/products/product-shirt.png',
                },
              ];
              
              final product = sampleProducts[index % sampleProducts.length];
              
              return _buildProductCard(context, product, isDark);
            },
          ),
        ],
      ),
    );
  }

  // New method for product cards with dark mode support
  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor, // Theme-aware card color
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
              // Product Image
              Container(
                height: 150,
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
              
              // Product Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      
                      // Price Row
                      Row(
                        children: [
                          Text(
                            '₦${product['price']}',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: TColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '₦${product['originalPrice']}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      
                      const Spacer(),
                      
                      // Add to Cart Button
                      SizedBox(
                        width: double.infinity,
                        height: 32,
                        child: ElevatedButton(
                          onPressed: () {},
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
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Discount Badge
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
          
          // Favorite Button
          Positioned(
            top: 8,
            right: 8,
            child: Container(
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
                  onTap: () {},
                  child: const Icon(
                    Icons.favorite_border,
                    size: 16,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandCard(BuildContext context, String name, int index, bool isDark, List<String> images) {
    return Container(
      padding: const EdgeInsets.all(TSizes.sm),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor, // Theme-aware background
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
          // Brand Header
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
                child: Icon(
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
          
          // Brand Products Images - Better aligned with proper spacing
          if (images.isNotEmpty) ...[
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              height: 70, // Fixed height for consistency
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
    final isDark = THelperFunctions.isDarkMode(context);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor, // Theme-aware background
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) => false;
}