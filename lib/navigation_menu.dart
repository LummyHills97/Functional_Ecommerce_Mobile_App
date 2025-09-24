import 'package:ecommerce_store/features/authentication/screens/home/home.dart';
import 'package:ecommerce_store/features/authentication/screens/store/store.dart';
import 'package:ecommerce_store/features/personalization/screens/settings/settings.dart';
import 'package:ecommerce_store/features/authentication/screens/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  final int initialIndex;
  
  const NavigationMenu({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());
    
    // Set initial index if provided
    if (initialIndex != 0) {
      controller.selectedIndex.value = initialIndex;
    }

    return Obx(() => Scaffold(
      body: controller.screens[controller.selectedIndex.value],
      bottomNavigationBar: NavigationBar(
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: controller.changeIndex,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        indicatorColor: Theme.of(context).primaryColor.withOpacity(0.1),
        surfaceTintColor: Colors.transparent,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Iconsax.home_2,
              color: controller.selectedIndex.value == 0 
                  ? Theme.of(context).primaryColor 
                  : Colors.grey,
            ),
            selectedIcon: Icon(
              Iconsax.home_25,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.shop,
              color: controller.selectedIndex.value == 1 
                  ? Theme.of(context).primaryColor 
                  : Colors.grey,
            ),
            selectedIcon: Icon(
              Iconsax.shop5,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Store',
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.heart,
              color: controller.selectedIndex.value == 2 
                  ? Theme.of(context).primaryColor 
                  : Colors.grey,
            ),
            selectedIcon: Icon(
              Iconsax.heart5,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Wishlist',
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.user,
              color: controller.selectedIndex.value == 3 
                  ? Theme.of(context).primaryColor 
                  : Colors.grey,
            ),
            selectedIcon: Icon(
              Iconsax.user5,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Profile',
          ),
        ],
      ),
    ));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = const [
    HomePage(),
    Store(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  // Navigate to specific screen programmatically
  void navigateToScreen(int index) {
    if (index >= 0 && index < screens.length) {
      selectedIndex.value = index;
    }
  }

  // Navigate to cart (you can call this from anywhere)
  void navigateToCart() {
    Get.toNamed('/cart');
  }
}
