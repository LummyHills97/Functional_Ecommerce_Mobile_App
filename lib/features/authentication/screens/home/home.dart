import 'package:ecommerce_store/common/widgets/custom_shapes/circular_container.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: TColors.primary,
              padding: const EdgeInsets.all(0),
              child: Stack(
                children: [
                  // Background circular container
                  TCircular(
                    width: 480,
                    height: 480,
                    backgroundColor: TColors.textWhite.withOpacity(0.1),
                  ),
                  // You can add more positioned widgets here
                  Positioned(
                    top: -150,
                    right: -250,
                    child: TCircular(
                      width: 400,
                      height: 400,
                      backgroundColor: TColors.textWhite.withOpacity(0.1),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    right: -300,
                    child: TCircular(
                      width: 400,
                      height: 400,
                      backgroundColor: TColors.textWhite.withOpacity(0.1),
                    ),
                  ),
                  // Your content can go here
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        // Add your header content here
                        Text(
                          'Good day for shopping',
                          style: TextStyle(
                            color: TColors.textWhite,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Welcome to our store',
                          style: TextStyle(
                            color: TColors.textWhite.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Add search bar or other widgets here
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Add more content below the header
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Featured Products',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  // Add your product grid or list here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}