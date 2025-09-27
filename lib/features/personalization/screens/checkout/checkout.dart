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
                    showQuantityControls: false, // Fixed property name
                    showRemoveButton: false,     // Hide remove button for checkout
                    backgroundColor: Theme.of(context).cardColor,
                    borderRadius: 12,
                  );
                },
              )),
              
              const SizedBox(height: TSizes.spaceBtwSections),
              
              // Order Summary Section
              _buildOrderSummary(context, cartController),
              
              const SizedBox(height: TSizes.spaceBtwSections),
              
              // Payment Method Section
              _buildPaymentMethod(context),
              
              const SizedBox(height: TSizes.spaceBtwSections),
              
              // Delivery Address Section
              _buildDeliveryAddress(context),
              
              const SizedBox(height: TSizes.spaceBtwSections * 2),
              
              // Place Order Button
              _buildPlaceOrderButton(context, cartController),
            ],
          ),
        ),
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

  Widget _buildPaymentMethod(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outline.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.credit_card, color: cs.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Credit Card',
                      style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '**** **** **** 1234',
                      style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to payment method selection
                },
                child: const Text('Change'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outline.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Address',
            style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.location_on, color: cs.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Home',
                      style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '123 Main Street, City, State 12345',
                      style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to address selection
                },
                child: const Text('Change'),
              ),
            ],
          ),
        ],
      ),
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
                // Handle order placement
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
          title: const Text('Order Placed!'),
          content: Text(
            'Your order of \$${cartController.total.toStringAsFixed(2)} has been placed successfully.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                cartController.clearCart(); // Clear cart after order
                Get.back(); // Return to previous screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}