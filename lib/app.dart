import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_store/features/personalization/screens/cart/widgets/cart.dart';
import 'package:ecommerce_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecommerce_store/features/authentication/screens/login/login.dart';
import 'package:ecommerce_store/navigation_menu.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/theme/theme.dart';

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

/// Example of the corrected deals section widget
Widget _buildDealsSection(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Today's Deals",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(height: TSizes.spaceBtwItems),
      Container(
        height: 120,
        width: double.infinity,
        clipBehavior: Clip.hardEdge, // ✅ prevents pixel overflow
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.grey[800]!, Colors.grey[700]!]
                : [Colors.blue[50]!, Colors.blue[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(TSizes.md),
          border: isDarkMode
              ? Border.all(color: Colors.grey[600]!, width: 1)
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Row(
            children: [
              Flexible( // ✅ keeps text from overflowing
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Flash Sale',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : TColors.primary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Limited time offers',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDarkMode
                                ? Colors.grey[300]
                                : Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: TColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Shop Now',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.local_fire_department,
                size: 46, // ✅ slightly smaller
                color: Colors.red[400],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
