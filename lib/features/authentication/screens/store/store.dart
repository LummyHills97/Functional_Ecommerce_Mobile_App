import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_store/common/widgets/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_store/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/navigation_menu.dart';
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
              onPressed: () => Get.find<NavigationController>().changeIndex(2),
              iconColor: isDark ? TColors.white : TColors.dark,
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    const Padding(
                      padding: EdgeInsets.all(TSizes.defaultSpace),
                      child: TSearchContainer(text: 'Search in Store'),
                    ),

                    // Featured Brands Section
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
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: TSizes.gridViewSpacing,
                          crossAxisSpacing: TSizes.gridViewSpacing,
                          mainAxisExtent: 80,
                        ),
                        itemBuilder: (_, index) {
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
                                          Icon(
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
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    isScrollable: true,
                    indicatorColor: TColors.primary,
                    unselectedLabelColor: TColors.darkerGrey,
                    labelColor: TColors.primary,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
                    tabs: const [
                      Tab(child: Text('Sport')),
                      Tab(child: Text('Furniture')),
                      Tab(child: Text('Electronics')),
                      Tab(child: Text('Clothes')),
                      Tab(child: Text('Cosmetics')),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: TColors.darkGrey,
              ),
            ),
            const SizedBox(height: 400), // Example space to simulate scroll
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Container(
      color: isDark ? TColors.black : TColors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}