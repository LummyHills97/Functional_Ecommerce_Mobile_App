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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔍 Search bar
              const TSearchContainer(text: 'Search in Store'),
              const SizedBox(height: TSizes.spaceBtwSections),

              // ⭐ Featured Brands
              TSectionHeading(
                title: 'Featured Brands',
                showActionButton: true,
                buttonTitle: 'View all',
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.sm),
              GridView.builder(
                padding: EdgeInsets.zero,
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

              const SizedBox(height: TSizes.spaceBtwSections),

              // 🧭 Tabs (Start AFTER featured brands)
              const TabBar(
                isScrollable: true,
                indicatorColor: TColors.primary,
                unselectedLabelColor: TColors.darkerGrey,
                labelColor: TColors.primary,
                tabs: [
                  Tab(child: Text('Sport')),
                  Tab(child: Text('Furniture')),
                  Tab(child: Text('Electronics')),
                  Tab(child: Text('Clothes')),
                  Tab(child: Text('Cosmetics')),
                ],
              ),

              // 🛍️ Tab content
              SizedBox(
                height: 400, // Set fixed height or use MediaQuery
                child: TabBarView(
                  children: [
                    Center(child: Text('Sport products go here')),
                    Center(child: Text('Furniture products go here')),
                    Center(child: Text('Electronics products go here')),
                    Center(child: Text('Clothes products go here')),
                    Center(child: Text('Cosmetics products go here')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
