import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final couponController = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final availableCoupons = [
      {'code': 'SAVE10', 'discount': 10.0, 'description': '10% off on all items'},
      {'code': 'WELCOME20', 'discount': 20.0, 'description': '20% off for new customers'},
      {'code': 'FLASH50', 'discount': 50.0, 'description': 'Flat \$50 off on orders above \$200'},
      {'code': 'FREESHIP', 'discount': 15.0, 'description': 'Free shipping + \$15 off'},
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Apply Coupon',
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
              'Enter Coupon Code',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : TColors.dark,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: couponController,
                    style: TextStyle(color: isDark ? Colors.white : TColors.dark),
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: 'Enter code here',
                      hintStyle: TextStyle(
                        color: isDark ? Colors.grey[600] : Colors.grey[400],
                      ),
                      prefixIcon: Icon(
                        Icons.local_offer,
                        color: isDark ? Colors.white70 : TColors.dark,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: TColors.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
                      ),
                      filled: true,
                      fillColor: isDark ? Colors.grey[850] : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.sm),
                ElevatedButton(
                  onPressed: () {
                    final code = couponController.text.toUpperCase().trim();
                    if (code.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please enter a coupon code',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }
                    
                    final coupon = availableCoupons.firstWhereOrNull(
                      (c) => c['code'] == code,
                    );
                    
                    if (coupon != null) {
                      cartController.applyCoupon(code);
                      Get.back();
                      Get.snackbar(
                        'Success!',
                        'Coupon ${coupon['code']} applied successfully!',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 2),
                      );
                    } else {
                      Get.snackbar(
                        'Invalid Code',
                        'The coupon code you entered is not valid',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.md + 4,
                      vertical: TSizes.md + 4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
                    ),
                  ),
                  child: const Text('Apply'),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            Text(
              'Available Coupons',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : TColors.dark,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            ...availableCoupons.map((coupon) {
              return Padding(
                padding: const EdgeInsets.only(bottom: TSizes.sm),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[850] : Colors.white,
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
                    border: Border.all(
                      color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(TSizes.sm),
                    leading: Container(
                      padding: const EdgeInsets.all(TSizes.sm),
                      decoration: BoxDecoration(
                        color: TColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.local_offer,
                        color: TColors.primary,
                      ),
                    ),
                    title: Text(
                      coupon['code'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDark ? Colors.white : TColors.dark,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        coupon['description'] as String,
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        couponController.text = coupon['code'] as String;
                      },
                      child: const Text(
                        'Use Code',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}