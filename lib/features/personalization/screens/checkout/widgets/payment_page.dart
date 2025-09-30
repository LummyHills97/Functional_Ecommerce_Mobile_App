import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final paymentMethods = [
      "Credit Card",
      "Debit Card",
      "PayPal",
      "Cash on Delivery",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Select Payment Method")),
      body: ListView.builder(
        itemCount: paymentMethods.length,
        itemBuilder: (context, index) {
          final method = paymentMethods[index];
          return Obx(() => ListTile(
                title: Text(method),
                trailing: cartController.selectedPaymentMethod.value == method
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  cartController.selectedPaymentMethod.value = method;
                  Get.back(); // Return to order review
                },
              ));
        },
      ),
    );
  }
}
