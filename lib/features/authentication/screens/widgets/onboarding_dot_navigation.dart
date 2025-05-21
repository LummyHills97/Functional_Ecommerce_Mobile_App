import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/device/device_utility.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
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
    final isDark = THelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: 0,
      right: 80, // This shifts it slightly away from the right edge (where the button is)
      child: Align(
        alignment: Alignment.centerLeft,
        child: SmoothPageIndicator(
          controller: controller,
          count: 3,
          effect: ExpandingDotsEffect(
            activeDotColor: isDark ? TColors.light : Colors.black,
            dotHeight: 6,
            dotWidth: 8,
            spacing: 8,
          ),
        ),
      ),
    );
  }
}
