import 'package:ecommerce_store/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:ecommerce_store/navigation_menu.dart';
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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Our Store',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text(
                  'Store products will be displayed here',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}