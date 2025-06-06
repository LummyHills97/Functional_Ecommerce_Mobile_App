// ignore_for_file: prefer_const_constructors
import 'package:ecommerce_store/features/authentication/screens/Onboarding/onboarding.dart';
import 'package:ecommerce_store/features/authentication/screens/login/login.dart';
import 'package:ecommerce_store/navigation_menu.dart';
import 'package:ecommerce_store/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      
      // Set initial route
      initialRoute: '/onboarding',
      
      // Define all routes
      getPages: [
        GetPage(
          name: '/onboarding',
          page: () => OnboardingScreen(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/navigation',
          page: () => NavigationMenu(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/home',
          page: () => NavigationMenu(),
          transition: Transition.fade,
        ),
      ],
      
      // Fallback route for unknown routes
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => Scaffold(
          body: Center(
            child: Text('Page Not Found'),
          ),
        ),
      ),
    );
  }
}