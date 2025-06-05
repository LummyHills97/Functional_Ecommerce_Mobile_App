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
                  Container(
                    width: 480,
                    height: 480,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(400),
                      color: TColors.textWhite.withOpacity(0.1),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}