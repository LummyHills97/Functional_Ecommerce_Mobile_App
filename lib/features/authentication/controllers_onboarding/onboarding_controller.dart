import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  var currentPageIndex = 0.obs;

  void updatePageIndicator(int index) {
    currentPageIndex.value = index;
  }

  void nextPage() {
    if (currentPageIndex.value < 2) {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  void skipPage() {
    pageController.jumpToPage(2);
  }

  void navigateToHomeScreen() {
    // Navigate to login screen instead of home
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}