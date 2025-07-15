import 'package:ecommerce_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_store/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:ecommerce_store/navigation_menu.dart';
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
        title: const Text(
          'Store',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TCartCounterIcon(
            onPressed: () {
              // Navigate to cart page
              Get.find<NavigationController>().changeIndex(2);
            },
            iconColor: Colors.black,
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: THelperFunctions.isDarkMode(context) 
                  ? Colors.black 
                  : Colors.white,
              expandedHeight: 440,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  shrinkWrap: true, 
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // Search bar
                    SizedBox(height: TSizes.spaceBtwItems),
                    TSearchContainer(text: '',)
                    // Categories
                    // Featured brands
                  ],
                ),
              ),
            ),
          ];
        },
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Products grid or list
              Text('Products will be displayed here'),
            ],
          ),
        ),
      ),
    );
  }
}