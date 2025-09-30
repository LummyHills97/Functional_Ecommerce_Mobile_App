import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final addresses = [
      "No. 5, Adewale Street, Lagos",
      "12 Allen Avenue, Ikeja",
      "45 Ring Road, Ibadan",
    ].obs;

    void _showAddAddressDialog() {
      final TextEditingController addressController = TextEditingController();

      Get.defaultDialog(
        title: "Add New Address",
        content: Column(
          children: [
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: "Enter your address",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (addressController.text.isNotEmpty) {
                  addresses.add(addressController.text);
                  cartController.selectedAddress.value =
                      addressController.text;
                  Get.back(); // close dialog
                }
              },
              child: const Text("Save Address"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Address"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_location_alt),
            onPressed: _showAddAddressDialog,
          ),
        ],
      ),
      body: Obx(() => ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return ListTile(
                title: Text(address),
                trailing: cartController.selectedAddress.value == address
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  cartController.selectedAddress.value = address;
                  Get.back(); // Return to order review
                },
              );
            },
          )),
    );
  }
}
