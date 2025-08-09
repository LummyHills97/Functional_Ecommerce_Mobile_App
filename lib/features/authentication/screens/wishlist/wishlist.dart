import 'package:ecommerce_store/common/widgets/products.cart/product_cards/product_card_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/navigation_menu.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // ✅ Dark mode friendly
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor:
                  isDarkMode ? Colors.white12 : Colors.grey.shade200,
              child: IconButton(
                icon: Icon(
                  Iconsax.add,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  /// Navigate back to the home tab in NavigationMenu
                  Get.offAll(() => const NavigationMenu(initialIndex: 0));
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            TGridLayout(
              itemCount: 4, // Replace with your wishlist count
              itemBuilder: (_, index) => const TProductCardVertical(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple grid layout for products
class TGridLayout extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  const TGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
