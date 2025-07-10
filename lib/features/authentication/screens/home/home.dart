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
      height: 380, // Reduced from 420
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const THomeAppBar(),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildSearchBar(),
            const SizedBox(height: TSizes.spaceBtwItems), // Reduced spacing
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

  /// Popular categories section - FIXED OVERFLOW
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
          height: 70, // Reduced from 80
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

  /// Body content below header - FIXED OVERFLOW
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

  /// FIXED: Popular products section - MAJOR OVERFLOW FIX
  Widget _buildPopularProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded( // FIXED: Wrap with Expanded
              child: Text(
                'Popular Products',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
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
        // FIXED: Better grid configuration
        LayoutBuilder(
          builder: (context, constraints) {
            // Calculate width available for each item
            final availableWidth = constraints.maxWidth;
            final itemWidth = (availableWidth - TSizes.spaceBtwItems) / 2;
            final aspectRatio = itemWidth / 280; // Approximate card height
            
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: aspectRatio.clamp(0.6, 0.8), // Constrain aspect ratio
                crossAxisSpacing: TSizes.spaceBtwItems,
                mainAxisSpacing: TSizes.spaceBtwItems,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const TProductCardVertical();
              },
            );
          },
        ),
      ],
    );
  }

  /// Banner carousel - FIXED HEIGHT
  Widget _buildBannerCarousel() {
    return BannerCarousel(
      banners: BannerData.banners,
      height: 160, // Further reduced from 180
      onBannerTap: (banner) {
        // TODO: Handle banner tap - navigate to promotion/product page
        debugPrint('Tapped on banner: ${banner.title}');
      },
    );
  }

  /// Featured products section - FIXED OVERFLOW
  Widget _buildFeaturedProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded( // FIXED: Wrap with Expanded
              child: Text(
                'Featured Products',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            TCircular(
              width: 36, // Reduced from 40
              height: 36, // Reduced from 40
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: 18,
              onTap: () => debugPrint('View all featured products'),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 14, // Reduced from 16
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        // FIXED: Better height management
        SizedBox(
          height: 95, // Further reduced from 110
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 65, // Fixed width to prevent overflow
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TCircular(
                      width: 65,
                      height: 65,
                      backgroundColor: Colors.grey[100]!,
                      borderRadius: 32.5,
                      onTap: () => debugPrint('Product $index tapped'),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 28, // Reduced from 30
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4), // Reduced spacing
                    Flexible( // FIXED: Use Flexible to prevent overflow
                      child: Text(
                        'Product ${index + 1}',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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

  /// Deals section - FIXED HEIGHT
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
        Container(
          height: 80, // Further reduced from 90
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

/// FIXED: Enhanced category item using TCircular - OVERFLOW FIXED
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
      child: SizedBox(
        width: 50, // FIXED: Set fixed width to prevent overflow
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TCircular(
              width: 50, // Reduced from 56
              height: 50, // Reduced from 56
              backgroundColor: Colors.white,
              borderRadius: 25,
              onTap: onTap,
              child: Center(
                child: category.imagePath.isNotEmpty
                    ? Image.asset(
                        category.imagePath,
                        width: 28, // Reduced from 32
                        height: 28, // Reduced from 32
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            category.icon,
                            size: 28,
                            color: Theme.of(context).primaryColor,
                          );
                        },
                      )
                    : Icon(
                        category.icon,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
              ),
            ),
            const SizedBox(height: 4), // Reduced spacing
            // FIXED: Better text handling
            Text(
              category.name,
              style: Theme.of(context).textTheme.labelSmall?.copyWith( // Changed to labelSmall
                    fontWeight: FontWeight.w500,
                    color: TColors.textWhite,
                  ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

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

/// FIXED: Banner carousel widget with auto-scroll and indicators - OVERFLOW FIXED
class BannerCarousel extends StatefulWidget {
  final List<Banner> banners;
  final double height;
  final Function(Banner)? onBannerTap;
  final Duration autoPlayDuration;

  const BannerCarousel({
    super.key,
    required this.banners,
    this.height = 160, // Reduced default height
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
                  padding: const EdgeInsets.all(TSizes.sm), // Reduced padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (banner.title.isNotEmpty)
                        Text(
                          banner.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16, // Reduced from 18
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (banner.description != null)
                        Text(
                          banner.description!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12, // Reduced from 14
                          ),
                          maxLines: 1, // Reduced from 2
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
          width: _currentIndex == index ? 20 : 6, // Reduced sizes
          height: 6,
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? Theme.of(context).primaryColor
                : Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(3),
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