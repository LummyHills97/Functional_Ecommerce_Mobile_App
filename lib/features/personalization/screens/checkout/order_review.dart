import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/t_cart_items.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/features/personalization/screens/checkout/widgets/address_page.dart';
import 'package:ecommerce_store/features/personalization/screens/checkout/widgets/coupon_page.dart';
import 'package:ecommerce_store/features/personalization/screens/checkout/widgets/payment_page.dart';
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
              // Section Title
              Text(
                'Items in your order',
                style: tt.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Cart Items List
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

              // Coupon Section
              GestureDetector(
                onTap: () {
                  Get.to(() => const CouponPage());
                },
                child: Container(
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
                      const Icon(Icons.card_giftcard),
                      const SizedBox(width: TSizes.sm),
                      Text(
                        'Have a promo code? Enter here',
                        style: tt.bodyMedium,
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Address Section
              GestureDetector(
                onTap: () => Get.to(() => const AddressPage()),
                child: Container(
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
                      const Icon(Icons.location_on),
                      const SizedBox(width: TSizes.sm),
                      Expanded(
                        child: Obx(() => Text(
                              cartController.selectedAddress.value ??
                                  'Select delivery address',
                              style: tt.bodyMedium,
                            )),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Payment Method Section
              GestureDetector(
                onTap: () => Get.to(() => const PaymentMethodPage()),
                child: Container(
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
                      const Icon(Icons.payment),
                      const SizedBox(width: TSizes.sm),
                      Expanded(
                        child: Obx(() => Text(
                              cartController.selectedPaymentMethod.value ??
                                  'Select payment method',
                              style: tt.bodyMedium,
                            )),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Price Breakdown Section
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
}
