import 'package:ecommerce_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_store/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/navigation_menu.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_store/common/widgets/appbar.dart';
import 'package:get/get.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Store',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.dark,
          ),
        ),
        actions: [
          // Notification icon
          IconButton(
            onPressed: () {
              // Handle notifications
            },
            icon: Icon(
              Icons.notifications_outlined,
              color: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.dark,
            ),
          ),
          // Cart icon
          TCartCounterIcon(
            onPressed: () {
              // Navigate to cart page
              Get.find<NavigationController>().changeIndex(2);
            },
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
              backgroundColor: THelperFunctions.isDarkMode(context)
                  ? TColors.black
                  : TColors.white,
              expandedHeight: 440,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // Search bar - simplified
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
                      child: const TSearchContainer(
                        text: 'Search in Store',
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    
                    // Featured Brands
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TSectionHeading(
                          title: 'Featured Brands',
                          onPressed: () {},
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                        // Brand showcase container
                        Container(
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
                              // Icon
                              Container(
                                width: 56,
                                height: 56,
                                padding: const EdgeInsets.all(TSizes.sm),
                                decoration: BoxDecoration(
                                  color: THelperFunctions.isDarkMode(context) 
                                      ? TColors.black 
                                      : TColors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Image(
                                  image: AssetImage(TImages.clothIcon),
                                  color: THelperFunctions.isDarkMode(context) 
                                      ? TColors.white 
                                      : TColors.dark,
                                ),
                              ),
                              const SizedBox(width: TSizes.spaceBtwItems),
                              
                              // Brand info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Nike',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    Text(
                                      '256 Products',
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: TSizes.spaceBtwItems),
                        
                        // Brands Grid
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
                                  // Brand icon
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
                                    child: Image(
                                      image: AssetImage(TImages.clothIcon),
                                      color: THelperFunctions.isDarkMode(context) 
                                          ? TColors.white 
                                          : TColors.dark,
                                    ),
                                  ),
                                  const SizedBox(width: TSizes.spaceBtwItems / 2),
                                  
                                  // Brand name
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Brand ${index + 1}',
                                          style: Theme.of(context).textTheme.labelLarge,
                                          overflow: TextOverflow.ellipsis,
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
            ),
          ];
        },
        body: const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Products grid or list
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
    );
  }
}