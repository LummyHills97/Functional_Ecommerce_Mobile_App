import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final couponController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply Coupon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your promo code below',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: couponController,
              decoration: const InputDecoration(
                hintText: 'Promo code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final code = couponController.text.trim();
                if (code.isNotEmpty) {
                  cartController.applyCoupon(code);
                  Get.back(); // return to order review
                }
              },
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
