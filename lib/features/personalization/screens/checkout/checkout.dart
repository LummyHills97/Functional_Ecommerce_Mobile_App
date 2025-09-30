import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/t_cart_items.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true, 
        title: Text(
          'Order Review', 
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Items Section
              Text(
                'Items in your order',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              
              // Cart Items List - Read-only for checkout
              Obx(() => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartController.cartItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
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
              
              // Coupon Section
              GestureDetector(
                onTap: () => Get.toNamed('/coupon'),
                child: _buildSelectableBox(
                  context,
                  icon: Icons.card_giftcard,
                  text: 'Have a promo code? Enter here',
                ),
              ),
              
              const SizedBox(height: TSizes.spaceBtwSections),
              
              // Delivery Address Section
              GestureDetector(
                onTap: () => Get.toNamed('/address'),
                child: Obx(() => _buildSelectableBox(
                  context,
                  icon: Icons.location_on,
                  text: cartController.selectedAddress.value ?? 'Select delivery address',
                )),
              ),
              
              const SizedBox(height: TSizes.spaceBtwSections),
              
              // Payment Method Section
              GestureDetector(
                onTap: () => Get.toNamed('/payment'),
                child: Obx(() => _buildSelectableBox(
                  context,
                  icon: Icons.payment,
                  text: cartController.selectedPaymentMethod.value ?? 'Select payment method',
                )),
              ),
              
              const SizedBox(height: TSizes.spaceBtwSections),
              
              // Order Summary Section
              _buildOrderSummary(context, cartController),
              
              const SizedBox(height: TSizes.spaceBtwSections * 2),
              
              // Place Order Button
              _buildPlaceOrderButton(context, cartController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectableBox(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.md,
        vertical: TSizes.sm,
      ),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border.all(color: cs.outline.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: cs.primary),
          const SizedBox(width: TSizes.sm),
          Expanded(
            child: Text(
              text,
              style: tt.bodyMedium,
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: cs.onSurfaceVariant),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, CartController cartController) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Obx(() => Column(
            children: [
              _buildSummaryRow('Subtotal', cartController.subtotal, tt, cs),
              const SizedBox(height: 8),
              _buildSummaryRow('Shipping', cartController.shipping, tt, cs),
              const SizedBox(height: 8),
              _buildSummaryRow('Tax', cartController.tax, tt, cs),
              
              // Show discount if coupon applied
              if (cartController.appliedCoupon.value != null) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount (${cartController.appliedCoupon.value})',
                      style: tt.bodyMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '-\$${cartController.discount.value.toStringAsFixed(2)}',
                      style: tt.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
              
              const Divider(height: 24),
              _buildSummaryRow(
                'Total',
                cartController.total,
                tt,
                cs,
                isTotal: true,
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    double amount,
    TextTheme tt,
    ColorScheme cs, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: tt.bodyMedium?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? cs.onSurface : cs.onSurfaceVariant,
          ),
        ),
        Text(
          amount == 0 ? 'FREE' : '\$${amount.toStringAsFixed(2)}',
          style: tt.bodyMedium?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? cs.primary : cs.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceOrderButton(BuildContext context, CartController cartController) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Obx(() => ElevatedButton(
        onPressed: cartController.cartItems.isNotEmpty
            ? () {
                _showOrderConfirmation(context, cartController);
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag_outlined),
            const SizedBox(width: 8),
            Text(
              'Place Order • \$${cartController.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _showOrderConfirmation(BuildContext context, CartController cartController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary, size: 28),
              const SizedBox(width: 12),
              const Text('Order Placed!'),
            ],
          ),
          content: Text(
            'Your order of \$${cartController.total.toStringAsFixed(2)} has been placed successfully.\n\nYou will receive a confirmation email shortly.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                cartController.clearCart();
                Get.offAllNamed('/navigation'); // Navigate to home
              },
              child: const Text('Continue Shopping'),
            ),
          ],
        );
      },
    );
  }
}