// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_store/features/authentication/screens/Onboarding/onboarding.dart';
import 'package:ecommerce_store/features/authentication/screens/login/login.dart';
import 'package:ecommerce_store/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';

// Import your login screen here
// import 'package:ecommerce_store/features/authentication/screens/login/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App',
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      
      // Define routes instead of using home
      initialRoute: '/onboarding',
      getPages: [
        GetPage(
          name: '/onboarding', 
          page: () => OnboardingScreen(),
        ),
        GetPage(
          name: '/login', 
          page: () => LoginScreen(), // Replace with your actual login screen
        ),
        // Add more routes as needed
        // GetPage(name: '/home', page: () => HomeScreen()),
        // GetPage(name: '/signup', page: () => SignupScreen()),
      ],
    );
  }
}