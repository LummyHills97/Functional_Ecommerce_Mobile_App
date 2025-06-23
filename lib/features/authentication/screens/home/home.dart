import 'package:flutter/material.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_store/common/widgets/home_appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart'; // Added missing import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER SECTION: AppBar, Search, Categories
            TPrimaryHeaderContainer(
              height: 420,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const THomeAppBar(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Search Bar
                    TSearchContainer(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TSearchContainer(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// Popular Categories
                    Text(
                      'Popular Categories',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: TColors.textWhite,
                          ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
                            child: CategoryItem(
                              category: categories[index],
                              onTap: () {
                                // Handle category tap
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// BODY CONTENT BELOW HEADER
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TSizes.md), // Fixed: TSizes().md to TSizes.md
              ),
              child: const Image(image: AssetImage(TImages.promoBanner1)), // Fixed: Removed extra parentheses and commas
            ),
          ], // Fixed: Removed extra closing parentheses and commas
        ),
      ),
    );
  }
}

/// Category Model
class Category {
  final String name;
  final String imagePath;
  final IconData? icon;

  Category({
    required this.name,
    required this.imagePath,
    this.icon,
  });
}

/// Category Display Widget
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
        children: [
          /// Category Image
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
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
                          category.icon ?? Icons.category,
                          size: 32,
                          color: Theme.of(context).primaryColor,
                        );
                      },
                    )
                  : Icon(
                      category.icon ?? Icons.category,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),

          /// Category Name
          SizedBox(
            width: 56,
            child: Text(
              category.name,
              style: Theme.of(context).textTheme.labelMedium,
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

/// Sample Categories Data
final List<Category> categories = [
  Category(name: 'Electronics', imagePath: 'assets/images/categories/electronics.png', icon: Icons.phone_android),
  Category(name: 'Clothing', imagePath: 'assets/images/categories/clothing.png', icon: Icons.checkroom),
  Category(name: 'Books', imagePath: 'assets/images/categories/books.png', icon: Icons.book),
  Category(name: 'Sports', imagePath: 'assets/images/categories/sports.png', icon: Icons.sports_soccer),
  Category(name: 'Beauty', imagePath: 'assets/images/categories/beauty.png', icon: Icons.face),
  Category(name: 'Home', imagePath: 'assets/images/categories/home.png', icon: Icons.home),
];