import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  final PageController controller;

  const OnBoardingDotNavigation({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 90,
      left: 20, // Adjust this as needed
      child: SmoothPageIndicator(
        controller: controller,
        count: 3,
        effect: ExpandingDotsEffect(
              activeDotColor: Colors.black,
              dotHeight: 6,
              dotWidth: 8,
              spacing: 8,
        ),
      ),
    );
  }
}
