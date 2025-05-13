import 'package:ecommerce_store/app.dart';
import 'package:ecommerce_store/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App', // Fixed here
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Text(
            'Awesome! 🎊 Project Structure is set up and running. \n Happy T Coding 🎊',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
