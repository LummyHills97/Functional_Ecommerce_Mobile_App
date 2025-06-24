import 'package:flutter/material.dart';
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

  /// Popular categories section
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
              return CategoryItem(
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
          _buildPromoBanner(),
          const SizedBox(height: TSizes.spaceBtwSections),
          _buildFeaturedProducts(context),
          const SizedBox(height: TSizes.spaceBtwSections),
          _buildDealsSection(context),
        ],
      ),
    );
  }

  /// Promo banner with error handling
  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      height: 190,
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
        child: Image.asset(
          "assets/images/banners/banner_3.jpg",
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
      ),
    );
  }

  /// Featured products section
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
            TextButton(
              onPressed: () {
                // TODO: Navigate to featured products screen
                debugPrint('View all featured products');
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        // TODO: Add featured products grid/list
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(TSizes.sm),
          ),
          child: const Center(
            child: Text('Featured Products Coming Soon'),
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
    // This is a simplified version - you might want to implement a more robust mapping
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

/// Enhanced category display widget
class CategoryItem extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryItem({
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
          _buildCategoryImage(context),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          _buildCategoryName(context),
        ],
      ),
    );
  }

  /// Category image with animation and better error handling
  Widget _buildCategoryImage(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
    );
  }

  /// Category name with better text handling
  Widget _buildCategoryName(BuildContext context) {
    return SizedBox(
      width: 56,
      child: Text(
        category.name,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Centralized category data management
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