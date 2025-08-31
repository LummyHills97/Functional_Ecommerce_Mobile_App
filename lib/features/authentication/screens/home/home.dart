import 'package:ecommerce_store/common/widgets/products.cart/product_cards/product_card_vertical.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';

// Mock data models
class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category({required this.name, required this.icon, required this.color});
}

class Banner {
  final String title;
  final String description;
  final String imageUrl;

  Banner({required this.title, required this.description, required this.imageUrl});
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Mock categories data
  static final List<Category> _categories = [
    Category(name: 'Electronics', icon: Icons.phone_android, color: Colors.blue),
    Category(name: 'Fashion', icon: Icons.shopping_bag, color: Colors.pink),
    Category(name: 'Home', icon: Icons.home, color: Colors.green),
    Category(name: 'Books', icon: Icons.book, color: Colors.orange),
    Category(name: 'Sports', icon: Icons.sports_soccer, color: Colors.red),
    Category(name: 'Beauty', icon: Icons.face, color: Colors.purple),
  ];

  // Mock banners data
  static final List<Banner> _banners = [
    Banner(
      title: 'Summer Sale',
      description: 'Up to 50% off on selected items',
      imageUrl: 'assets/images/banners/banner_1.jpg',
    ),
    Banner(
      title: 'Free Shipping',
      description: 'On orders above \$50',
      imageUrl: 'assets/images/banners/banner_3.jpg',
    ),
  ];

  // Mock product data
  static final List<Map<String, dynamic>> _popularProducts = [
    {
      'name': 'Nike Wildhorse Trail',
      'brand': 'Nike',
      'image': 'assets/images/products/NikeWildhorse.png',
      'price': 129.99,
      'originalPrice': 159.99,
      'discount': 19,
    },
    {
      'name': 'Nike Air Max',
      'brand': 'Nike', 
      'image': 'assets/images/products/nike-shoes.png',
      'price': 89.99,
      'originalPrice': 119.99,
      'discount': 25,
    },
    {
      'name': 'Adidas Ultraboost',
      'brand': 'Adidas',
      'image': 'assets/images/products/adidas-shoes.png',
      'price': 149.99,
      'originalPrice': 179.99,
      'discount': 17,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(context),
            _buildBodyContent(context),
          ],
        ),
      ),
    );
  }

  // HEADER - Fixed app bar positioning
  Widget _buildHeader(BuildContext context) {
    return TPrimaryHeaderContainer(
      height: 420,
      child: Column(
        children: [
          // Custom App Bar - Fixed positioning
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good day for shopping',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: TColors.grey,
                        ),
                      ),
                      Text(
                        'Taimoor Sikander',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: TColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined, color: TColors.white),
                        onPressed: () => debugPrint('Cart pressed'),
                      ),
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: TColors.black,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Center(
                            child: Text(
                              '2',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: TColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: TSizes.spaceBtwItems),
          
          // Search Container - Properly positioned
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: TSearchContainer(
              onTap: () => debugPrint('Search tapped'),
            ),
          ),
          
          const SizedBox(height: TSizes.spaceBtwSections),
          
          // Popular Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: _buildPopularCategories(context),
          ),
        ],
      ),
    );
  }

  // CATEGORIES
  Widget _buildPopularCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Categories',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: TColors.textWhite,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final category = _categories[index];
              return _CategoryItem(
                category: category,
                onTap: () => debugPrint('Tapped ${category.name}'),
              );
            },
          ),
        ),
      ],
    );
  }

  // BODY
  Widget _buildBodyContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBannerCarousel(),
          const SizedBox(height: TSizes.spaceBtwSections),
          _buildPopularProducts(context),
          const SizedBox(height: TSizes.spaceBtwSections),
          _buildFeaturedProducts(context),
          const SizedBox(height: TSizes.spaceBtwSections),
          _buildDealsSection(context),
        ],
      ),
    );
  }

  // BANNER
  Widget _buildBannerCarousel() {
    return _BannerCarousel(
      banners: _banners,
      height: 190,
      onBannerTap: (banner) {
        debugPrint('Tapped on banner: ${banner.title}');
      },
    );
  }

  // POPULAR PRODUCTS - Updated to use TProductCardVertical with product data
  Widget _buildPopularProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Popular Products', () {
          debugPrint('View all popular products');
        }),
        const SizedBox(height: TSizes.spaceBtwItems),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _popularProducts.length,
            separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final product = _popularProducts[index];
              return SizedBox(
                width: 180,
                child: TProductCardVertical(product: product),
              );
            },
          ),
        ),
      ],
    );
  }

  // FEATURED PRODUCTS - Enhanced with better dark mode support
  Widget _buildFeaturedProducts(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Featured Categories', () {
          debugPrint('View all featured');
        }),
        const SizedBox(height: TSizes.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => debugPrint('Electronics category tapped'),
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: isDarkMode 
                            ? Colors.orange[800]?.withOpacity(0.3)
                            : Colors.orange[100],
                        shape: BoxShape.circle,
                        border: isDarkMode
                            ? Border.all(color: Colors.orange[600]!, width: 1)
                            : null,
                      ),
                      child: Icon(
                        Icons.laptop_mac,
                        size: 32,
                        color: isDarkMode 
                            ? Colors.orange[400]
                            : Colors.orange[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Electronics',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: GestureDetector(
                onTap: () => debugPrint('Fashion category tapped'),
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: isDarkMode 
                            ? Colors.pink[800]?.withOpacity(0.3)
                            : Colors.pink[100],
                        shape: BoxShape.circle,
                        border: isDarkMode
                            ? Border.all(color: Colors.pink[600]!, width: 1)
                            : null,
                      ),
                      child: Icon(
                        Icons.checkroom,
                        size: 32,
                        color: isDarkMode 
                            ? Colors.pink[400]
                            : Colors.pink[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fashion',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: GestureDetector(
                onTap: () => debugPrint('Sports category tapped'),
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: isDarkMode 
                            ? Colors.green[800]?.withOpacity(0.3)
                            : Colors.green[100],
                        shape: BoxShape.circle,
                        border: isDarkMode
                            ? Border.all(color: Colors.green[600]!, width: 1)
                            : null,
                      ),
                      child: Icon(
                        Icons.sports_soccer,
                        size: 32,
                        color: isDarkMode 
                            ? Colors.green[400]
                            : Colors.green[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sports',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // DEALS - Enhanced design
  Widget _buildDealsSection(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Today\'s Deals', () {
          debugPrint('View all deals');
        }),
        const SizedBox(height: TSizes.spaceBtwItems),
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode 
                  ? [Colors.grey[800]!, Colors.grey[700]!]
                  : [Colors.blue[50]!, Colors.blue[100]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(TSizes.md),
            border: isDarkMode 
                ? Border.all(color: Colors.grey[600]!, width: 1)
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Flash Sale',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : TColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Limited time offers',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDarkMode 
                              ? Colors.grey[300]
                              : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: TColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Shop Now',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.local_fire_department,
                  size: 48,
                  color: Colors.red[400],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // REUSABLE TITLE + BUTTON
  Widget _buildSectionTitle(BuildContext context, String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        TextButton(
          onPressed: onViewAll,
          child: Text(
            'View All', 
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}

// Custom CategoryItem widget
class _CategoryItem extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: category.color.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Icon(
              category.icon,
              color: category.color,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            category.name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: TColors.textWhite,
                  fontSize: 12,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// Custom BannerCarousel widget
class _BannerCarousel extends StatefulWidget {
  final List<Banner> banners;
  final double height;
  final Function(Banner) onBannerTap;

  const _BannerCarousel({
    required this.banners,
    required this.height,
    required this.onBannerTap,
  });

  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentIndex < widget.banners.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.banners.length,
            itemBuilder: (context, index) {
              final banner = widget.banners[index];
              return GestureDetector(
                onTap: () => widget.onBannerTap(banner),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(TSizes.md),
                    gradient: LinearGradient(
                      colors: [
                        TColors.primary.withOpacity(0.8),
                        TColors.primary.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          banner.title,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        Text(
                          banner.description,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white70,
                              ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        ElevatedButton(
                          onPressed: () => widget.onBannerTap(banner),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: TColors.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Shop Now',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.banners.length,
            (index) => Container(
              width: _currentIndex == index ? 20 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}