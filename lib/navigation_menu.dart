import 'package:ecommerce_store/features/authentication/screens/home/home.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: Colors.white,
          indicatorColor: TColors.primary.withOpacity(0.1),
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.shop),
              label: 'Store',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.heart),
              label: 'Wishlist',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    Container(
      color: Colors.purple,
      child: const Center(
        child: Text(
          'Store Screen',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.orange,
      child: const Center(
        child: Text(
          'Wishlist Screen',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    ),
  ];
}