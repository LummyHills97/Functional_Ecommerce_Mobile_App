import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/features/personalization/screens/checkout/widgets/address_page.dart';
import 'package:ecommerce_store/features/personalization/screens/checkout/widgets/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ecommerce_store/features/personalization/screens/cart/widgets/cart.dart';
import 'package:ecommerce_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecommerce_store/features/authentication/screens/login/login.dart';
import 'package:ecommerce_store/navigation_menu.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/theme/theme.dart';
import 'package:ecommerce_store/features/personalization/screens/checkout/widgets/coupon_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ecommerce Store',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,

      /// Initialize dependencies
      initialBinding: BindingsBuilder(() {
        Get.put(CartController(), permanent: true);
      }),

      /// Initial route
      initialRoute: '/onboarding',

      /// Defined routes
      getPages: [
        GetPage(
          name: '/onboarding',
          page: () => OnboardingScreen(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/navigation',
          page: () => const NavigationMenu(initialIndex: 0),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/cart',
          page: () => const CartScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/address',
          page: () => const AddressPage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/payment',
          page: () => const PaymentMethodPage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/coupon',
          page: () => const CouponPage(),
          transition: Transition.rightToLeft,
        ),
      ],

      /// Fallback for unknown routes
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => const Scaffold(
          body: Center(
            child: Text('Page Not Found'),
          ),
        ),
      ),
    );
  }
}
