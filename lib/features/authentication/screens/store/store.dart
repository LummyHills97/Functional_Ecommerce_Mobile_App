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
              onPressed: () {
                // Replace with your actual logic or leave commented
                // Get.find<NavigationController>().changeIndex(2);
              },
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
                      height: 200, // enough space for 2 rows of GridView
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
                          final brands = ['Nike', 'Adidas', 'Puma', 'Reebok'];
                          return Container(
                            padding: const EdgeInsets.all(TSizes.sm),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isDark ? TColors.darkGrey : TColors.grey,
                              ),
                              borderRadius: BorderRadius.circular(TSizes.productImageRadius),
                            ),
                            child: Row(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            brands[index],
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
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            SliverPersistentHeader(
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
                context,
              ),
              pinned: true,
            ),
          ],
          body: TabBarView(
            children: [
              _buildTabContent('Sport products go here', isDark),
              _buildTabContent('Furniture products go here', isDark),
              _buildTabContent('Electronics products go here', isDark),
              _buildTabContent('Clothes products go here', isDark),
              _buildTabContent('Cosmetics products go here', isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(String text, bool isDark) {
    return Container(
      color: isDark ? TColors.black : TColors.white,
      child: ListView.builder(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: isDark ? TColors.darkGrey.withOpacity(0.1) : TColors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: Border.all(
              color: isDark ? TColors.darkGrey : TColors.grey.withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product ${index + 1}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDark ? TColors.white : TColors.dark,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: TSizes.sm),
              Text(
                'This is a sample product description for $text category.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark ? TColors.grey : TColors.darkGrey,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.child, this.context);

  final Widget child;
  final BuildContext context;

  @override
  double get minExtent => 48;
  @override
  double get maxExtent => 48;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Container(
      color: isDark ? TColors.black : TColors.white,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
