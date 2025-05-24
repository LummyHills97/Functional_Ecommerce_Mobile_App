import 'package:ecommerce_store/features/authentication/controllers_onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/text_strings.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // PageView
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          // Skip Button
          Obx(() => controller.currentPageIndex.value < 2
              ? Positioned(
                  top: MediaQuery.of(context).padding.top + 16,
                  right: 16,
                  child: TextButton(
                    onPressed: controller.skipPage,
                    child: const Text('Skip'),
                  ),
                )
              : const SizedBox()),

          // Dot Navigation
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 90,
            left: 16,
            child: Obx(() => SmoothPageIndicator(
                  controller: controller.pageController,
                  count: 3,
                  onDotClicked: controller.dotNavigationClick,
                  effect: ExpandingDotsEffect(
                    activeDotColor: isDark ? TColors.light : TColors.dark,
                    dotHeight: 6,
                    dotWidth: 8,
                    spacing: 8,
                  ),
                )),
          ),

          // Next / Get Started Button
          Obx(() => Positioned(
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom + 30,
                child: controller.currentPageIndex.value == 2
                    ? ElevatedButton(
                        onPressed: controller.navigateToHomeScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? TColors.primary : Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: controller.nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? TColors.primary : Colors.black,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Icon(Iconsax.arrow_right_3, color: Colors.white),
                      ),
              )),
        ],
      ),
    );
  }
}

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: screenWidth * 0.8,
            height: screenHeight * 0.6,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
