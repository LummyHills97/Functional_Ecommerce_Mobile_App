import 'package:ecommerce_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_store/common/widgets/products.cart/product_cards/product_card_vertical.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_store/common/widgets/home_appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildHeaderSection(context),
            _buildBodyContent(context),
          ],
        ),
      ),
    );
  }

  /// Header section with AppBar, Search, and Categories
  Widget _buildHeaderSection(BuildContext context) {
    return TPrimaryHeaderContainer(
      height: 420,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const THomeAppBar(),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildSearchBar(),
            const SizedBox(height: TSizes.spaceBtwSections),
            _buildPopularCategories(context),
          ],
        ),
      ),
    );
  }

  /// Search bar with tap handler
  Widget _buildSearchBar() {
    return TSearchContainer(
      onTap: () {
        // TODO: Implement navigation to search screen
        // Navigator.pushNamed(context, '/search');
        debugPrint('Search tapped');
      },
    );
  }

  /// Popular categories section - ENHANCED WITH TCIRCULAR
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
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: CategoryData.categories.length,
            separatorBuilder: (context, index) => 
                const SizedBox(width: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              return CategoryItemWithTCircular(
                category: CategoryData.categories[index],
                onTap: () => _handleCategoryTap(CategoryData.categories[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Body content below header
  Widget _buildBodyContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBannerCarousel(),
          const SizedBox(height: TSizes.spaceBtwSections),
          _buildPopularProducts(context), // UPDATED: Popular products instead of quick actions
          const SizedBox(height: TSizes.spaceBtwSections),
          _buildFeaturedProducts(context),
          const SizedBox(height: TSizes.spaceBtwSections),
          _buildDealsSection(context),
        ],
      ),
    );
  }

  /// UPDATED: Popular products section using TProductCardVertical
  Widget _buildPopularProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular Products',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to all products page
                debugPrint('View all popular products');
              },
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        // Horizontal scrollable product cards
        SizedBox(
          height: 280, // Adjust height based on your product card
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 3, // Show 3 products as requested
            separatorBuilder: (context, index) => 
                const SizedBox(width: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              return const TProductCardVertical();
            },
          ),
        ),
      ],
    );
  }

  /// Banner carousel with multiple images
  Widget _buildBannerCarousel() {
    return BannerCarousel(
      banners: BannerData.banners,
      height: 190,
      onBannerTap: (banner) {
        // TODO: Handle banner tap - navigate to promotion/product page
        debugPrint('Tapped on banner: ${banner.title}');
      },
    );
  }

  /// Featured products section - ENHANCED WITH TCIRCULAR
  Widget _buildFeaturedProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Products',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            TCircular(
              width: 40,
              height: 40,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: 20,
              onTap: () => debugPrint('View all featured products'),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        // Sample featured products using TCircular
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  TCircular(
                    width: 80,
                    height: 80,
                    backgroundColor: Colors.grey[100]!,
                    borderRadius: 40,
                    onTap: () => debugPrint('Product $index tapped'),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 32,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Product ${index + 1}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  /// Deals section
  Widget _buildDealsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Deals',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        // TODO: Add deals grid/list
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(TSizes.sm),
          ),
          child: const Center(
            child: Text('Deals Coming Soon'),
          ),
        ),
      ],
    );
  }

  /// Handle category tap
  void _handleCategoryTap(Category category) {
    // TODO: Navigate to category screen
    debugPrint('Tapped on ${category.name}');
    // Navigator.pushNamed(context, '/category', arguments: category);
  }
}

/// Enhanced category item using TCircular
class CategoryItemWithTCircular extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryItemWithTCircular({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TCircular(
            width: 56,
            height: 56,
            backgroundColor: Colors.white,
            borderRadius: 28,
            onTap: onTap,
            child: Center(
              child: category.imagePath.isNotEmpty
                  ? Image.asset(
                      category.imagePath,
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          category.icon,
                          size: 32,
                          color: Theme.of(context).primaryColor,
                        );
                      },
                    )
                  : Icon(
                      category.icon,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          SizedBox(
            width: 56,
            child: Text(
              category.name,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: TColors.textWhite,
                  ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Keep all your existing classes (Category, CategoryItem, Banner, BannerCarousel, etc.)
// They remain the same...

/// Category model with validation
class Category {
  final String id;
  final String name;
  final String imagePath;
  final IconData icon;

  const Category({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.icon,
  });

  /// Factory constructor for creating from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imagePath: json['imagePath'] ?? '',
      icon: _getIconFromString(json['icon']),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'icon': icon.codePoint.toString(),
    };
  }

  /// Helper method to get IconData from string
  static IconData _getIconFromString(String? iconString) {
    switch (iconString) {
      case 'phone_android':
        return Icons.phone_android;
      case 'checkroom':
        return Icons.checkroom;
      case 'book':
        return Icons.book;
      case 'sports_soccer':
        return Icons.sports_soccer;
      case 'face':
        return Icons.face;
      case 'home':
        return Icons.home;
      default:
        return Icons.category;
    }
  }
}

/// Banner model for carousel
class Banner {
  final String id;
  final String title;
  final String imagePath;
  final String? description;
  final String? actionUrl;

  const Banner({
    required this.id,
    required this.title,
    required this.imagePath,
    this.description,
    this.actionUrl,
  });
}

/// Banner carousel widget with auto-scroll and indicators
class BannerCarousel extends StatefulWidget {
  final List<Banner> banners;
  final double height;
  final Function(Banner)? onBannerTap;
  final Duration autoPlayDuration;

  const BannerCarousel({
    super.key,
    required this.banners,
    this.height = 190,
    this.onBannerTap,
    this.autoPlayDuration = const Duration(seconds: 4),
  });

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    if (widget.banners.length > 1) {
      _autoPlayTimer = Timer.periodic(widget.autoPlayDuration, (timer) {
        if (_currentIndex < widget.banners.length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }
        
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  void _resumeAutoPlay() {
    _stopAutoPlay();
    _startAutoPlay();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return _buildEmptyBanner();
    }

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
              return GestureDetector(
                onTap: () {
                  widget.onBannerTap?.call(widget.banners[index]);
                },
                onTapDown: (_) => _stopAutoPlay(),
                onTapUp: (_) => _resumeAutoPlay(),
                onTapCancel: () => _resumeAutoPlay(),
                child: _buildBannerItem(widget.banners[index]),
              );
            },
          ),
        ),
        if (widget.banners.length > 1) ...[
          const SizedBox(height: TSizes.spaceBtwItems),
          _buildPageIndicator(),
        ],
      ],
    );
  }

  Widget _buildBannerItem(Banner banner) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.md),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TSizes.md),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              banner.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
            if (banner.title.isNotEmpty || banner.description != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (banner.title.isNotEmpty)
                        Text(
                          banner.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (banner.description != null)
                        Text(
                          banner.description!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.banners.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentIndex == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? Theme.of(context).primaryColor
                : Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyBanner() {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(TSizes.md),
      ),
      child: const Center(
        child: Text('No banners available'),
      ),
    );
  }
}

/// Centralized banner data management
class BannerData {
  // Banner image paths
  static const String promoBanner1 = "assets/images/products/promo-banner-1.png";
  static const String promoBanner2 = "assets/images/products/promo-banner-2.png";
  static const String promoBanner3 = "assets/images/products/promo-banner-3.png";

  static const List<Banner> banners = [
    Banner(
      id: '1',
      title: 'Special Offer',
      imagePath: promoBanner1,
      description: 'Don\'t miss out on amazing deals',
      actionUrl: '/promo-1',
    ),
    Banner(
      id: '2',
      title: 'Featured Products',
      imagePath: promoBanner2,
      description: 'Discover trending items',
      actionUrl: '/promo-2',
    ),
    Banner(
      id: '3',
      title: 'Best Sellers',
      imagePath: promoBanner3,
      description: 'Most popular items this week',
      actionUrl: '/promo-3',
    ),
  ];

  /// Get banner by ID
  static Banner? getBannerById(String id) {
    try {
      return banners.firstWhere((banner) => banner.id == id);
    } catch (e) {
      return null;
    }
  }
}

class CategoryData {
  static const List<Category> categories = [
    Category(
      id: '1',
      name: 'Electronics',
      imagePath: 'assets/images/categories/electronics.png',
      icon: Icons.phone_android,
    ),
    Category(
      id: '2',
      name: 'Clothing',
      imagePath: 'assets/images/categories/clothing.png',
      icon: Icons.checkroom,
    ),
    Category(
      id: '3',
      name: 'Books',
      imagePath: 'assets/images/categories/books.png',
      icon: Icons.book,
    ),
    Category(
      id: '4',
      name: 'Sports',
      imagePath: 'assets/images/categories/sports.png',
      icon: Icons.sports_soccer,
    ),
    Category(
      id: '5',
      name: 'Beauty',
      imagePath: 'assets/images/categories/beauty.png',
      icon: Icons.face,
    ),
    Category(
      id: '6',
      name: 'Home',
      imagePath: 'assets/images/categories/home.png',
      icon: Icons.home,
    ),
  ];

  /// Get category by ID
  static Category? getCategoryById(String id) {
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get categories by name pattern
  static List<Category> searchCategories(String query) {
    if (query.isEmpty) return categories;
    
    return categories
        .where((category) =>
            category.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}