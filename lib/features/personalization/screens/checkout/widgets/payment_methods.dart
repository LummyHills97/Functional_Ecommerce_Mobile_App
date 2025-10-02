import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Payment Method',
          style: TextStyle(
            color: isDark ? Colors.white : TColors.dark,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : TColors.dark,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Digital Wallets Section
            _buildSectionTitle(context, 'Digital Wallets', isDark),
            const SizedBox(height: TSizes.spaceBtwItems),
            Column(
              children: [
                Obx(() => _buildPaymentOption(
                  context,
                  'PayPal',
                  'assets/icons/payment_methods/paypal.png',
                  cartController,
                  isDark,
                )),
                const SizedBox(height: TSizes.sm),
                Obx(() => _buildPaymentOption(
                  context,
                  'Google Pay',
                  'assets/icons/payment_methods/google-pay.png',
                  cartController,
                  isDark,
                )),
                const SizedBox(height: TSizes.sm),
                Obx(() => _buildPaymentOption(
                  context,
                  'Apple Pay',
                  'assets/icons/payment_methods/apple-pay.png',
                  cartController,
                  isDark,
                )),
                const SizedBox(height: TSizes.sm),
                Obx(() => _buildPaymentOption(
                  context,
                  'Paystack',
                  'assets/icons/payment_methods/paystack.png',
                  cartController,
                  isDark,
                )),
                const SizedBox(height: TSizes.sm),
                Obx(() => _buildPaymentOption(
                  context,
                  'Paytm',
                  'assets/icons/payment_methods/paytm.png',
                  cartController,
                  isDark,
                )),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Cards Section
            _buildSectionTitle(context, 'Credit & Debit Cards', isDark),
            const SizedBox(height: TSizes.spaceBtwItems),
            Column(
              children: [
                Obx(() => _buildPaymentOption(
                  context,
                  'Credit Card',
                  'assets/icons/payment_methods/credit-card.png',
                  cartController,
                  isDark,
                )),
                const SizedBox(height: TSizes.sm),
                Obx(() => _buildPaymentOption(
                  context,
                  'Visa',
                  'assets/icons/payment_methods/visa.png',
                  cartController,
                  isDark,
                )),
                const SizedBox(height: TSizes.sm),
                Obx(() => _buildPaymentOption(
                  context,
                  'Mastercard',
                  'assets/icons/payment_methods/master-card.png',
                  cartController,
                  isDark,
                )),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Other Payment Methods
            _buildSectionTitle(context, 'Other Methods', isDark),
            const SizedBox(height: TSizes.spaceBtwItems),
            Obx(() => _buildPaymentOption(
              context,
              'Cash on Delivery',
              null,
              cartController,
              isDark,
              icon: Icons.local_shipping,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, bool isDark) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white70 : Colors.black87,
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    String method,
    String? imagePath,
    CartController controller,
    bool isDark, {
    IconData? icon,
  }) {
    final isSelected = controller.selectedPaymentMethod.value == method;

    return InkWell(
      onTap: () {
        controller.selectedPaymentMethod.value = method;
        // Add haptic feedback
        HapticFeedback.selectionClick();
        // Navigate back after a short delay for visual feedback
        Future.delayed(const Duration(milliseconds: 150), () {
          if (Get.isDialogOpen == false && Get.isBottomSheetOpen == false) {
            Get.back();
          }
        });
      },
      borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
      child: Container(
        padding: const EdgeInsets.all(TSizes.md),
        decoration: BoxDecoration(
          color: isSelected 
              ? TColors.primary.withOpacity(0.1)
              : (isDark ? Colors.grey[850] : Colors.white),
          borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
          border: Border.all(
            color: isSelected 
                ? TColors.primary
                : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            if (imagePath != null)
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.payment, size: 24);
                  },
                ),
              )
            else if (icon != null)
              Container(
                padding: const EdgeInsets.all(TSizes.sm),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: isDark ? Colors.white : TColors.dark,
                  size: 24,
                ),
              ),
            const SizedBox(width: TSizes.md),
            Expanded(
              child: Text(
                method,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : TColors.dark,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: TColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}

// Add this import at the top if not already present
