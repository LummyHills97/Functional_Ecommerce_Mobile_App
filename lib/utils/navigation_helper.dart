import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class NavigationHelper {
  static void navigateToCart() {
    final CartController cartController = Get.find<CartController>();

    if (cartController.cartItems.isEmpty) {
      Get.snackbar(
        'Empty Cart',
        'Your cart is empty. Add some items first!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    Get.toNamed('/cart');
  }

  static void navigateToCartFromWishlist() {
    Get.toNamed('/cart'); // simplified
  }
}

// Cart Icon Widget
class CartIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool showBadge;

  const CartIcon({
    Key? key,
    this.onPressed,
    this.showBadge = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Stack(
      children: [
        IconButton(
          onPressed: onPressed ?? NavigationHelper.navigateToCart,
          icon: const Icon(Icons.shopping_cart),
        ),
        if (showBadge)
          Obx(() => cartController.itemCount > 0
              ? Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartController.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : const SizedBox.shrink()),
      ],
    );
  }
}
