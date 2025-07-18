import 'package:ecommerce_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_store/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/navigation_menu.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_store/common/widgets/appbar.dart';
import 'package:get/get.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.dark,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                color: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.dark,
              ),
            ),
            TCartCounterIcon(
              onPressed: () => Get.find<NavigationController>().changeIndex(2),
              iconColor: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.dark,
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
                expandedHeight: 360, // Reduced to account for removed large container
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
                        child: const TSearchContainer(text: 'Search in Store'),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      // Featured Brands
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TSectionHeading(
                            title: 'Featured Brands',
                            showActionButton: true,
                            buttonTitle: 'View all',
                            onPressed: () {},
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                          GridView.builder(
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
                              // Sample brand names for variety
                              final brands = ['Nike', 'Adidas', 'Puma', 'Reebok'];
                              return Container(
                                padding: const EdgeInsets.all(TSizes.sm),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: THelperFunctions.isDarkMode(context)
                                        ? TColors.darkGrey
                                        : TColors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(TSizes.productImageRadius),
                                  color: Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.all(TSizes.xs),
                                      decoration: BoxDecoration(
                                        color: THelperFunctions.isDarkMode(context)
                                            ? TColors.black
                                            : TColors.white,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Icon(
                                        Icons.checkroom,
                                        color: THelperFunctions.isDarkMode(context)
                                            ? TColors.white
                                            : TColors.dark,
                                        size: 20,
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
                        ],
                      ),
                    ],
                  ),
                ),
                // Tabs
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: TColors.primary,
                  unselectedLabelColor: TColors.darkerGrey,
                  labelColor: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.primary,
                  tabs: [
                  Tab(child: Text('Sport')),
                  Tab(child: Text('Furniture')),
                  Tab(child: Text('Electronics')),
                  Tab(child: Text('Clothes')),
                  Tab(child: Text('Cosmetics')),
                  ]),
              ),
            ];
          },
          body: const Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                Text(
                  'Products will be displayed here',
                  style: TextStyle(
                    fontSize: 16,
                    color: TColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}