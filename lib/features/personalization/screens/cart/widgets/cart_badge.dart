import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CartBadgeWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? iconColor;
  final double iconSize;
  
  const CartBadgeWidget({
    super.key,
    this.onPressed,
    this.iconColor,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    
    return Obx(() {
      final itemCount = cartController.totalQuantity;
      
      return Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            onPressed: onPressed ?? () => Get.toNamed('/cart'),
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: iconColor ?? Theme.of(context).colorScheme.onSurface,
              size: iconSize,
            ),
          ),
          // Only show badge if there are items in cart
          if (itemCount > 0)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 1,
                  ),
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: Text(
                  itemCount > 99 ? '99+' : '$itemCount',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      );
    });
  }
}

// Alternative simpler version that just shows count (not quantity)
class SimpleCartBadge extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? iconColor;
  final double iconSize;
  
  const SimpleCartBadge({
    super.key,
    this.onPressed,
    this.iconColor,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    
    return Obx(() {
      final itemCount = cartController.itemCount; // This shows unique items, not total quantity
      
      return Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            onPressed: onPressed ?? () => Get.toNamed('/cart'),
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: iconColor ?? Theme.of(context).colorScheme.onSurface,
              size: iconSize,
            ),
          ),
          if (itemCount > 0)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 1,
                  ),
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: Text(
                  itemCount > 99 ? '99+' : '$itemCount',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      );
    });
  }
}