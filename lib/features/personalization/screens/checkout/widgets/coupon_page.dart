import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CouponPage extends StatelessWidget {
  const CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final couponController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Apply Coupon')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: couponController,
              decoration: const InputDecoration(
                hintText: 'Enter promo code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final code = couponController.text.trim();
                if (code.isNotEmpty) {
                  cartController.applyCoupon(code); // 👈 apply here
                  Get.back(); // 👈 pop back to OrderReview
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
