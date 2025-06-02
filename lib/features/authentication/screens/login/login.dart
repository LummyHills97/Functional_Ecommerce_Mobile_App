import 'package:ecommerce_store/common/widgets/login_form.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/text_strings.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, Title & Sub-Title
              _buildHeader(context, dark),

              /// Login Form Widget
              const LoginForm(),

              /// Divider
              _buildDivider(context, dark),

              /// Footer - Social Login Buttons
              _buildSocialLoginButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),
        ),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.sm),
        Text(
          TTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context, bool dark) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Divider(
                color: dark ? Colors.grey[700] : Colors.grey[400],
                thickness: 0.5,
                indent: 60,
                endIndent: 5,
              ),
            ),
            Text(
              TTexts.orSignInWith.toUpperCase(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Flexible(
              child: Divider(
                color: dark ? Colors.grey[700] : Colors.grey[400],
                thickness: 0.5,
                indent: 5,
                endIndent: 60,
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(TImages.google, () {
          // Handle Google login
          Get.snackbar('Info', 'Google login clicked');
        }),
        const SizedBox(width: TSizes.spaceBtwItems),
        _buildSocialButton(TImages.facebook, () {
          // Handle Facebook login
          Get.snackbar('Info', 'Facebook login clicked');
        }),
      ],
    );
  }

  Widget _buildSocialButton(String imagePath, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Image(
          width: TSizes.iconMd,
          height: TSizes.iconMd,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}