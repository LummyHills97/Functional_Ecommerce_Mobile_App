import 'package:ecommerce_store/features/authentication/screens/home/home.dart';
import 'package:ecommerce_store/features/authentication/screens/store/store.dart';
import 'package:ecommerce_store/features/authentication/screens/wishlist/wishlist_controller.dart';
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

    return Scaffold(
      body: Obx(() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            ),
          );
        },
        child: IndexedStack(
          key: ValueKey<int>(controller.selectedIndex.value),
          index: controller.selectedIndex.value,
          children: controller.screens,
        ),
      )),
      bottomNavigationBar: Obx(() => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: controller.changeIndex,
          backgroundColor: Colors.transparent,
          indicatorColor: Theme.of(context).primaryColor.withOpacity(0.15),
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          animationDuration: const Duration(milliseconds: 300),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(controller.selectedIndex.value == 0 ? 4 : 0),
                child: Icon(
                  controller.selectedIndex.value == 0 ? Iconsax.home_25 : Iconsax.home_2,
                  color: controller.selectedIndex.value == 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey[600],
                  size: controller.selectedIndex.value == 0 ? 24 : 22,
                ),
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(controller.selectedIndex.value == 1 ? 4 : 0),
                child: Icon(
                  controller.selectedIndex.value == 1 ? Iconsax.shop5 : Iconsax.shop,
                  color: controller.selectedIndex.value == 1
                      ? Theme.of(context).primaryColor
                      : Colors.grey[600],
                  size: controller.selectedIndex.value == 1 ? 24 : 22,
                ),
              ),
              label: 'Store',
            ),
            NavigationDestination(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(controller.selectedIndex.value == 2 ? 4 : 0),
                child: Icon(
                  controller.selectedIndex.value == 2 ? Iconsax.heart5 : Iconsax.heart,
                  color: controller.selectedIndex.value == 2
                      ? Theme.of(context).primaryColor
                      : Colors.grey[600],
                  size: controller.selectedIndex.value == 2 ? 24 : 22,
                ),
              ),
              label: 'Wishlist',
            ),
            NavigationDestination(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(controller.selectedIndex.value == 3 ? 4 : 0),
                child: Icon(
                  controller.selectedIndex.value == 3 ? Iconsax.user5 : Iconsax.user,
                  color: controller.selectedIndex.value == 3
                      ? Theme.of(context).primaryColor
                      : Colors.grey[600],
                  size: controller.selectedIndex.value == 3 ? 24 : 22,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      )),
    );
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
    if (index != selectedIndex.value) {
      selectedIndex.value = index;
      
      // Add haptic feedback for better UX
      if (GetPlatform.isAndroid || GetPlatform.isIOS) {
        _triggerHapticFeedback();
      }
    }
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

  // Private method for haptic feedback
  void _triggerHapticFeedback() {
    try {
      // You can add haptic feedback package here if needed
      // HapticFeedback.lightImpact();
    } catch (e) {
      // Handle gracefully if haptic feedback fails
      debugPrint('Haptic feedback not available: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize required controllers
    Get.put(WishlistController()); // Add this line to initialize WishlistController
    debugPrint('NavigationController initialized');
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('NavigationController disposed');
  }
}