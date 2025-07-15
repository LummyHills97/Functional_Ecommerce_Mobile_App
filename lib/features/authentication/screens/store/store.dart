import 'package:ecommerce_store/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_store/common/widgets/appbar.dart';


class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const Text('Store'),
        actions: [
          TCartCounterIcon(
            onPressed: () {
              // TODO: Handle cart button action
            },
            // iconColor: Colors.black, // optional
          ),
        ],
      ),
      body: const Center(
        child: Text('Store content goes here'),
      ),
    );
  }
}
