import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart'; // Make sure this package is added in pubspec.yaml

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: IconButton(
                icon: const Icon(Iconsax.add),
                onPressed: () {
                  // Add action here
                },
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text("Your Wishlist is empty"),
      ),
    );
  }
}
