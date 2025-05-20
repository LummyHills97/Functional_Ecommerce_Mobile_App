import 'package:ecommerce_store/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: 16.0,
      child: TextButton(
        onPressed: () {
          // Add your navigation logic here
        },
        child: const Text('Skip'),
      ),
    );
  }
}
