import 'package:ecommerce_store/features/authentication/screens/widgets/onboarding_dot_navigation.dart';
import 'package:ecommerce_store/features/authentication/screens/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce_store/features/authentication/controllers_onboarding/onboarding_controller.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/text_strings.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';

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

          // Dot Indicator
          OnBoardingDotNavigation(controller: controller.pageController),

          // Bottom Button
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
                        child: const Text('Get Started',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
