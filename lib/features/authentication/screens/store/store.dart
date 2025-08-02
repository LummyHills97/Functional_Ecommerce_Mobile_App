import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      length: 5,
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
                  const SizedBox(height: TSizes.sm),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: SizedBox(
                      height: 200,
                      child: GridView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: TSizes.gridViewSpacing,
                          crossAxisSpacing: TSizes.gridViewSpacing,
                          mainAxisExtent: 80,
                        ),
                        itemBuilder: (context, index) {
                          final featuredBrands = ['Nike', 'Adidas', 'Puma', 'Reebok'];
                          return _buildBrandCard(context, featuredBrands[index], index, isDark);
                        },
                      ),
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
                  unselectedLabelColor: TColors.darkerGrey,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(text: 'Sport'),
                    Tab(text: 'Furniture'),
                    Tab(text: 'Electronics'),
                    Tab(text: 'Clothes'),
                    Tab(text: 'Cosmetics'),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _buildBrandGrid(context, isDark, 'sport'),
              _buildBrandGrid(context, isDark, 'furniture'),
              _buildBrandGrid(context, isDark, 'electronics'),
              _buildBrandGrid(context, isDark, 'clothes'),
              _buildBrandGrid(context, isDark, 'cosmetics'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandGrid(BuildContext context, bool isDark, String category) {
    final brandMap = {
      'sport': ['Nike', 'Adidas', 'Puma', 'Reebok'],
      'furniture': ['IKEA', 'Ashley', 'Wayfair', 'HNI'],
      'electronics': ['Samsung', 'LG', 'Sony', 'Panasonic'],
      'clothes': ['Zara', 'H&M', 'Uniqlo', 'Levi’s'],
      'cosmetics': ['Fenty', 'Maybelline', 'L\'Oréal', 'MAC'],
    };

    final brandImages = {
      'Nike': [
        'assets/images/products/tracksuit_black.png',
        'assets/images/products/NikeAirMax.png',
        'assets/images/products/nike-shoes.png',
      ],
      'Adidas': [
        'assets/images/products/Adidas_Football.png',
        'assets/images/products/baseball_bat.png',
        'assets/images/products/product-jacket.png',
      ],
      'IKEA': [
        'assets/images/products/bedroom_sofa.png',
        'assets/images/products/bedroom_lamp.png',
        'assets/images/products/bedroom_bed_black.png',
      ],
      'Ashley': [
        'assets/images/products/bedroom_sofa.png',
        'assets/images/products/bedroom_lamp.png',
        'assets/images/products/bedroom_bed_black.png',
      ],
      'Samsung': [
        'assets/images/products/samsung_s9_mobile.png',
        'assets/images/products/acer_laptop_var_1.png',
        'assets/images/products/bedroom_bed_black.png',
      ],
      'Ashley': [
        'assets/images/products/bedroom_sofa.png',
        'assets/images/products/bedroom_lamp.png',
        'assets/images/products/bedroom_bed_black.png',
      ],
      // Add the rest similarly or reuse images
    };

    final brands = brandMap[category] ?? [];

    return GridView.builder(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      itemCount: brands.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: 0,
        mainAxisExtent: 140,
      ),
      itemBuilder: (context, index) {
        final name = brands[index];
        final images = brandImages[name] ?? [];
        return _buildBrandCard(context, name, index, isDark, images);
      },
    );
  }

  Widget _buildBrandCard(BuildContext context, String name, int index, bool isDark, [List<String> images = const []]) {
    return Container(
      padding: const EdgeInsets.all(TSizes.sm),
      decoration: BoxDecoration(
        border: Border.all(color: isDark ? TColors.darkGrey : TColors.grey),
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
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
                  color: isDark ? TColors.black : TColors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  Icons.checkroom,
                  size: 20,
                  color: isDark ? TColors.white : TColors.dark,
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
                          style: Theme.of(context).textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: TSizes.xs / 2),
                        const Icon(
                          Icons.verified,
                          color: TColors.primary,
                          size: 12,
                        ),
                      ],
                    ),
                    Text(
                      '${(index + 1) * 25} Products',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: TColors.darkGrey,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.sm),
          if (images.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: images.map((path) {
                  return Container(
                    margin: const EdgeInsets.only(right: TSizes.sm),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: TColors.light,
                    ),
                    child: Image.asset(path, fit: BoxFit.cover),
                  );
                }).toList(),
              ),
            ),
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
      color: isDark ? TColors.black : TColors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) => false;
}
