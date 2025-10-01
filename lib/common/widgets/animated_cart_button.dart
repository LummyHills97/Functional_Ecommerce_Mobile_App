import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:ecommerce_store/utils/constants/colors.dart';

class AnimatedCartButton extends StatefulWidget {
  final String productId;
  final String productName;
  final double productPrice;
  final String productImage;
  final double? width;
  final double? height;

  const AnimatedCartButton({
    super.key,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    this.width,
    this.height = 32,
  });

  @override
  State<AnimatedCartButton> createState() => _AnimatedCartButtonState();
}

class _AnimatedCartButtonState extends State<AnimatedCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    // Play animation
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // Handle cart logic
    final isInCart = cartController.isInCart(widget.productId);
    if (!isInCart) {
      cartController.quickAddToCart(
        productId: widget.productId,
        productName: widget.productName,
        productPrice: widget.productPrice,
        productImage: widget.productImage,
        productBrand: '', // TODO: Replace with actual brand if available
      );
    } else {
      cartController.removeFromCart(widget.productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: Obx(() {
        final isInCart = cartController.isInCart(widget.productId);
        return AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: ElevatedButton(
                onPressed: _handleTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isInCart ? Colors.green : TColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  elevation: isInCart ? 2 : 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Row(
                    key: ValueKey(isInCart),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isInCart ? Iconsax.tick_circle : Iconsax.add,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isInCart ? 'In Cart' : 'Add to Cart',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}