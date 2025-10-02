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
            Obx(() => Column(
              children: [
                _buildPaymentOption(
                  context,
                  'PayPal',
                  'assets/icons/payments_methods/paypal.png',
                  cartController,
                  isDark,
                ),
                const SizedBox(height: TSizes.sm),
                _buildPaymentOption(
                  context,
                  'Google Pay',
                  'assets/icons/payments_methods/google-pay.png',
                  cartController,
                  isDark,
                ),
                const SizedBox(height: TSizes.sm),
                _buildPaymentOption(
                  context,
                  'Apple Pay',
                  'assets/icons/payments_methods/apple-pay.png',
                  cartController,
                  isDark,
                ),
                const SizedBox(height: TSizes.sm),
                _buildPaymentOption(
                  context,
                  'Paystack',
                  'assets/icons/payments_methods/paystack.png',
                  cartController,
                  isDark,
                ),
              ],
            )),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Cards Section
            _buildSectionTitle(context, 'Credit & Debit Cards', isDark),
            const SizedBox(height: TSizes.spaceBtwItems),
            
            // Add New Card Button
            InkWell(
              onTap: () => _showAddCardDialog(context, cartController),
              child: Container(
                padding: const EdgeInsets.all(TSizes.md),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[850] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
                  border: Border.all(
                    color: TColors.primary.withOpacity(0.3),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(TSizes.sm),
                      decoration: BoxDecoration(
                        color: TColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add_card,
                        color: TColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: TSizes.md),
                    Text(
                      'Add New Card',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: TColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            // Saved Cards (if any)
            Obx(() {
              if (cartController.savedCards.isEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                children: cartController.savedCards.map((card) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: TSizes.sm),
                    child: _buildSavedCard(context, card, cartController, isDark),
                  );
                }).toList(),
              );
            }),

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
        Get.back();
      },
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

  Widget _buildSavedCard(
    BuildContext context,
    Map<String, String> card,
    CartController controller,
    bool isDark,
  ) {
    final cardNumber = card['number'] ?? '';
    final cardType = card['type'] ?? 'visa';
    final isSelected = controller.selectedPaymentMethod.value == 'Card ending in ${cardNumber.substring(cardNumber.length - 4)}';

    return InkWell(
      onTap: () {
        controller.selectedPaymentMethod.value = 'Card ending in ${cardNumber.substring(cardNumber.length - 4)}';
        Get.back();
      },
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
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                cardType.toLowerCase() == 'visa'
                    ? 'assets/icons/payments_methods/visa.png'
                    : 'assets/icons/payments_methods/credit-card.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: TSizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '•••• •••• •••• ${cardNumber.substring(cardNumber.length - 4)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : TColors.dark,
                    ),
                  ),
                  Text(
                    'Expires ${card['expiry']}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
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

  void _showAddCardDialog(BuildContext context, CartController controller) {
    final cardNumberController = TextEditingController();
    final cardHolderController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? TColors.dark : Colors.white,
        title: Text(
          'Add New Card',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : TColors.dark,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: isDark ? Colors.white : TColors.dark),
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
                  hintText: '1234 5678 9012 3456',
                  hintStyle: TextStyle(color: isDark ? Colors.grey[600] : Colors.grey[400]),
                  prefixIcon: Icon(Icons.credit_card, color: isDark ? Colors.white70 : TColors.dark),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: TColors.primary, width: 2),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  _CardNumberFormatter(),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextField(
                controller: cardHolderController,
                style: TextStyle(color: isDark ? Colors.white : TColors.dark),
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                  labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
                  hintText: 'John Doe',
                  hintStyle: TextStyle(color: isDark ? Colors.grey[600] : Colors.grey[400]),
                  prefixIcon: Icon(Icons.person, color: isDark ? Colors.white70 : TColors.dark),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: TColors.primary, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: expiryController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: isDark ? Colors.white : TColors.dark),
                      decoration: InputDecoration(
                        labelText: 'Expiry',
                        labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
                        hintText: 'MM/YY',
                        hintStyle: TextStyle(color: isDark ? Colors.grey[600] : Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: TColors.primary, width: 2),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        _ExpiryDateFormatter(),
                      ],
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextField(
                      controller: cvvController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      style: TextStyle(color: isDark ? Colors.white : TColors.dark),
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
                        hintText: '123',
                        hintStyle: TextStyle(color: isDark ? Colors.grey[600] : Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: TColors.primary, width: 2),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: isDark ? Colors.white70 : TColors.dark),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (cardNumberController.text.isNotEmpty &&
                  cardHolderController.text.isNotEmpty &&
                  expiryController.text.isNotEmpty &&
                  cvvController.text.isNotEmpty) {
                controller.addCard({
                  'number': cardNumberController.text.replaceAll(' ', ''),
                  'holder': cardHolderController.text,
                  'expiry': expiryController.text,
                  'cvv': cvvController.text,
                  'type': _getCardType(cardNumberController.text),
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Card added successfully'),
                    backgroundColor: TColors.primary,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Add Card'),
          ),
        ],
      ),
    );
  }

  String _getCardType(String number) {
    final cleanNumber = number.replaceAll(' ', '');
    if (cleanNumber.startsWith('4')) return 'Visa';
    if (cleanNumber.startsWith('5')) return 'Mastercard';
    return 'Credit Card';
  }
}

// Custom formatter for card number
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i + 1 != text.length) {
        buffer.write(' ');
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// Custom formatter for expiry date
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.length > 2) {
      return TextEditingValue(
        text: '${text.substring(0, 2)}/${text.substring(2)}',
        selection: TextSelection.collapsed(offset: text.length + 1),
      );
    }
    return newValue;
  }
}