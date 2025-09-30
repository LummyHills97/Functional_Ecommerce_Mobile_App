import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/t_cart_items.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            ],
          ),
        ),
      ),
    );
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
