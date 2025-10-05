import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/t_cart_items.dart';
import 'package:ecommerce_store/features/authentication/screens/order/widgets/order.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OrderReviewScreen extends StatelessWidget {
  const OrderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Order Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Section Title
              Text(
                'Items in your order',
                style: tt.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Cart Items List
              Obx(() => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartController.cartItems.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: TSizes.spaceBtwItems),
                    itemBuilder: (context, index) {
                      final item = cartController.cartItems[index];
                      return TCartItems(
                        item: item,
                        showQuantityControls: false,
                        showRemoveButton: false,
                        padding: const EdgeInsets.all(TSizes.md),
                      );
                    },
                  )),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Coupon Section
              GestureDetector(
                onTap: () => Get.toNamed('/coupon'),
                child: _buildSelectableBox(
                  context,
                  icon: Icons.card_giftcard,
                  text: 'Have a promo code? Enter here',
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Address Section
              GestureDetector(
                onTap: () => Get.toNamed('/address'),
                child: Obx(() => _buildSelectableBox(
                      context,
                      icon: Icons.location_on,
                      text: cartController.selectedAddress.value ??
                          'Select delivery address',
                    )),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Payment Method Section
              GestureDetector(
                onTap: () => Get.toNamed('/payment'),
                child: Obx(() => _buildSelectableBox(
                      context,
                      icon: Icons.payment,
                      text: cartController.selectedPaymentMethod.value ??
                          'Select payment method',
                    )),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Price Breakdown
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Subtotal: \$${cartController.subtotal.toStringAsFixed(2)}'),
                      Text(
                          'Shipping: \$${cartController.shipping.toStringAsFixed(2)}'),
                      Text('Tax: \$${cartController.tax.toStringAsFixed(2)}'),

                      if (cartController.appliedCoupon.value != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Coupon (${cartController.appliedCoupon.value}): '
                          '-\$${cartController.discount.value.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.green[700]),
                        ),
                      ],

                      const Divider(),

                      Text(
                        'Total: \$${cartController.total.toStringAsFixed(2)}',
                        style: tt.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: cs.primary,
                        ),
                      ),
                    ],
                  )),

              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
      
      /// Bottom Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => _handlePlaceOrder(context, cartController),
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Obx(() => Text(
                    'Place Order - \$${cartController.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  /// Handle Place Order
  void _handlePlaceOrder(BuildContext context, CartController cartController) {
    // Validate address and payment method
    if (cartController.selectedAddress.value == null) {
      Get.snackbar(
        'Missing Information',
        'Please select a delivery address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        icon: const Icon(Icons.warning, color: Colors.white),
      );
      return;
    }

    if (cartController.selectedPaymentMethod.value == null) {
      Get.snackbar(
        'Missing Information',
        'Please select a payment method',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        icon: const Icon(Icons.warning, color: Colors.white),
      );
      return;
    }

    // Show success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.tick_circle,
                  color: Colors.green,
                  size: 64,
                ),
              ),
              const SizedBox(height: 24),
              
              // Success Message
              Text(
                'Order Placed Successfully!',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              
              Text(
                'Your order has been placed successfully. You can track it in My Orders.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              
              // Order Number
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Order #${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: TColors.primary,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Get.offAll(() => const OrderScreen()); // Navigate to Orders and clear stack
              },
              child: const Text('View Orders'),
            ),
          ],
        );
      },
    );

    // TODO: Here you would typically:
    // 1. Send order to backend/database
    // 2. Clear cart
    // 3. Save order to user's order history
  }

  /// Reusable box widget
  Widget _buildSelectableBox(BuildContext context,
      {required IconData icon, required String text}) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.md,
        vertical: TSizes.sm,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: cs.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: TSizes.sm),
          Expanded(
            child: Text(
              text,
              style: tt.bodyMedium,
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}