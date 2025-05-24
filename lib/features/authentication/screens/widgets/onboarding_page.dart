import 'package:flutter/material.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';

class OnBoardingPage extends StatelessWidget {
  final String image, title, subTitle;

  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(subTitle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
