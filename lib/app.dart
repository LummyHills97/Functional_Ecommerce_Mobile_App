import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecommerce_store/features/authentication/screens/login/login.dart';
import 'package:ecommerce_store/navigation_menu.dart';
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
      ], // ✅ closed the list here

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
