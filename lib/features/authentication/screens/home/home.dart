import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_store/common/widgets/home_appbar.dart';
import 'package:ecommerce_store/common/widgets/products.cart/product_cards/product_card_vertical.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';

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

  // HEADER
  Widget _buildHeader(BuildContext context) {
    return TPrimaryHeaderContainer(
      height: 420,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const THomeAppBar(),
            const SizedBox(height: TSizes.spaceBtwItems),
            TSearchContainer(
              onTap: () => debugPrint('Search tapped'),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            _buildPopularCategories(context),
          ],
        ),
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

  // POPULAR PRODUCTS - Using ListView horizontal approach
  Widget _buildPopularProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Popular Products', () {
          debugPrint('View all popular products');
        }),
        const SizedBox(height: TSizes.spaceBtwItems),
        SizedBox(
          height: 280, // Fixed height to prevent overflow
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _popularProducts.length,
            separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final product = _popularProducts[index];
              return SizedBox(
                width: 160, // Fixed width for each product card
                child: Stack(
                  children: [
                    // Product card container
                    Container(
                      width: 160,
                      height: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(TSizes.sm),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product image
                          Container(
                            height: 160,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(TSizes.sm),
                                topRight: Radius.circular(TSizes.sm),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(TSizes.sm),
                                topRight: Radius.circular(TSizes.sm),
                              ),
                              child: Image.asset(
                                product['image'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 48,
                                    color: Colors.grey[400],
                                  );
                                },
                              ),
                            ),
                          ),
                          // Product details
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product['brand'],
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${product['price']}',
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '\$${product['originalPrice']}',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey[500],
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Discount badge
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
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
                    // Transparent favorite icon overlay
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
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
                            onTap: () {
                              debugPrint('Favorite pressed for ${product['name']}');
                            },
                            child: const Icon(
                              Icons.favorite_border,
                              size: 18,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // FEATURED PRODUCTS - Just 2 items in a row
  Widget _buildFeaturedProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Featured Products', () {
          debugPrint('View all featured');
        }),
        const SizedBox(height: TSizes.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _CircularContainer(
                    width: 70,
                    height: 70,
                    backgroundColor: Colors.orange[100]!,
                    borderRadius: 35,
                    child: Icon(
                      Icons.laptop_mac,
                      size: 32,
                      color: Colors.orange[700],
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
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: Column(
                children: [
                  _CircularContainer(
                    width: 70,
                    height: 70,
                    backgroundColor: Colors.pink[100]!,
                    borderRadius: 35,
                    child: Icon(
                      Icons.checkroom,
                      size: 32,
                      color: Colors.pink[700],
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
          ],
        ),
      ],
    );
  }

  // DEALS
  Widget _buildDealsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today\'s Deals', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: TSizes.spaceBtwItems),
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(TSizes.sm),
          ),
          child: const Center(child: Text('Deals Coming Soon')),
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
          child: Text('View All', style: TextStyle(color: Theme.of(context).primaryColor)),
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
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < widget.banners.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
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
                    image: DecorationImage(
                      image: AssetImage(banner.imageUrl),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
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
                            foregroundColor: Colors.blue,
                          ),
                          child: const Text('Shop Now'),
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
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
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

// Custom CircularContainer widget
class _CircularContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final double borderRadius;
  final Widget? child;

  const _CircularContainer({
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.borderRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}