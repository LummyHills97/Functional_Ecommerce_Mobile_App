import 'package:ecommerce_store/features/authentication/controllers_onboarding/onboarding_controller.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/text_strings.dart';
import 'package:ecommerce_store/utils/device/device_utility.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final OnboardingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(OnboardingController());
  }

  @override
  void dispose() {
    if (controller.pageController.hasClients) {
      controller.pageController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // PageView for onboarding pages
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
          Obx(() => Visibility(
                visible: controller.currentPageIndex.value < 2,
                child: Positioned(
                  top: TDeviceUtils.getAppBarHeight(),
                  right: TSizes.spaceBtwSections,
                  child: TextButton(
                    onPressed: controller.skipPage,
                    child: const Text('Skip', semanticsLabel: 'Skip onboarding'),
                  ),
                ),
              )),

          // Dot Navigation
          OnBoardingDotNavigation(controller: controller),

          // Next/Get Started Button
          Obx(() => controller.currentPageIndex.value == 2
              ? OnBoardingFinalButton(controller: controller)
              : OnBoardingNextButton(controller: controller)),
        ],
      ),
    );
  }
}

class OnBoardingDotNavigation extends StatelessWidget {
  final OnboardingController controller;

  const OnBoardingDotNavigation({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: TSizes.spaceBtwSections,
      right: TSizes.spaceBtwSections * 3,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Obx(
          () => SmoothPageIndicator(
            controller: controller.pageController,
            count: 3,
            onDotClicked: controller.dotNavigationClick,
            effect: ExpandingDotsEffect(
              activeDotColor: isDark ? TColors.light : TColors.dark,
              dotHeight: 6,
              dotWidth: 8,
              spacing: 8,
            ),
          ),
        ),
      ),
    );
  }
}

class OnBoardingNextButton extends StatelessWidget {
  final OnboardingController controller;

  const OnBoardingNextButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: controller.nextPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: dark ? TColors.primary : Colors.black,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16),
        ),
        child: const Icon(
          Iconsax.arrow_right_3,
          color: Colors.white,
          semanticLabel: 'Next',
        ),
      ),
    );
  }
}

class OnBoardingFinalButton extends StatelessWidget {
  final OnboardingController controller;

  const OnBoardingFinalButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: controller.navigateToHomeScreen,
        style: ElevatedButton.styleFrom(
          backgroundColor: dark ? TColors.primary : Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: const Text(
          'Get Started',
          semanticsLabel: 'Get Started with the app',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: width * 0.8,
            height: height * 0.55,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 60),
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
