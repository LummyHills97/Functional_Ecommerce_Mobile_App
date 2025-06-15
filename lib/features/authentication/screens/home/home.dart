import 'package:flutter/material.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_store/common/widgets/home_appbar.dart';
import 'package:ecommerce_store/common/widgets/search_container.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header Section
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  const THomeAppBar(),
                  
                  /// Search Bar with navigation
                  TSearchContainer(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TSearchContainer(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            
            /// Body Content
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Text(
                    'Body Content Goes Here',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  // Add additional widgets here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}