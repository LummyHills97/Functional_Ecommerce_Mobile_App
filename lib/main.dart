import 'package:ecommerce_store/app.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  // Initialize the CartController globally
  Get.put(CartController());
  
  // Todo: Add Widgets Binding
  // Todo: init Local Storage
  // Todo: Await Native Splash
  // Todo: Initialize Firebase
  // Todo: Initialize Authentication
  runApp(const App());
}