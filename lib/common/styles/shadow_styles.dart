// lib/utils/constants/shadow_styles.dart
import 'package:flutter/material.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';

class TShadowStyle {
  static const verticalProductShadow = BoxShadow(
    color: TColors.grey,
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0, 2),
  );

  static const horizontalProductShadow = BoxShadow(
    color: TColors.grey,
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0, 2),
  );

  static final cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      spreadRadius: 2,
      offset: const Offset(0, 4),
    ),
  ];

  static final elevatedButtonShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 8,
      spreadRadius: 1,
      offset: const Offset(0, 3),
    ),
  ];

  static final bottomSheetShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 5,
      offset: const Offset(0, -5),
    ),
  ];
}