import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';

class ProductAddToCartDialog {
  static void show({
    required BuildContext context,
    required Map<String, dynamic> product,
    required CartController cartController,
  }) {
    String? selectedSize;
    String? selectedColor;

    final sizes = ['S', 'M', 'L', 'XL'];
    final colors = ['Black', 'White', 'Blue', 'Red', 'Green'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(product['image'], height: 120, fit: BoxFit.cover),
                const SizedBox(height: 16),

                Text("\$${product['price']}", style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: TColors.primary,
                )),
                const SizedBox(height: 16),

                const Text('Select Size:', style: TextStyle(fontWeight: FontWeight.w600)),
                Wrap(
                  spacing: 8,
                  children: sizes.map((size) {
                    final isSelected = selectedSize == size;
                    return ChoiceChip(
                      label: Text(size),
                      selected: isSelected,
                      onSelected: (selected) => setState(() {
                        selectedSize = selected ? size : null;
                      }),
                      selectedColor: TColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                const Text('Select Color:', style: TextStyle(fontWeight: FontWeight.w600)),
                Wrap(
                  spacing: 8,
                  children: colors.map((color) {
                    final isSelected = selectedColor == color;
                    return ChoiceChip(
                      label: Text(color),
                      selected: isSelected,
                      onSelected: (selected) => setState(() {
                        selectedColor = selected ? color : null;
                      }),
                      selectedColor: TColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: (selectedSize != null && selectedColor != null)
                  ? () {
                      cartController.quickAddToCart(
                        productId: product['id'],
                        productName: product['name'],
                        productPrice: product['price'].toDouble(),
                        productImage: product['image'],
                        productBrand: product['brand'],
                        productSize: selectedSize,
                        productColor: selectedColor,
                      );

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("${product['name']} ($selectedColor, $selectedSize) added to cart"),
                        backgroundColor: TColors.primary,
                      ));
                    }
                  : null,
              style: ElevatedButton.styleFrom(backgroundColor: TColors.primary),
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
