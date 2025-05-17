import 'package:get/get.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  /// variables
  
  /// Update Current Index when Page scroll
  void updatePageIndicator(index) {}

  /// jump to the specific dot selected page
  void dotNavigationclick(index) {}

  /// update current index & jump to next page
  void nextPage() {}

  /// update Current index & jump to the last page
  void skipPage () {}
}