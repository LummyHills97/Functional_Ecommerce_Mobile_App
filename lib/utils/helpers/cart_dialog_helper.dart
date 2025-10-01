import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';

class CartDialogHelper {
  /// Shows a dialog to select size and color before adding to cart
  /// 
  /// Parameters:
  /// - availableSizes: List of sizes for this product (empty list = no size selection)
  /// - availableColors: List of colors for this product (empty list = no color selection)
  static void showAddToCartDialog({
    required BuildContext context,
    required Map<String, dynamic> product,
    List<String>? availableSizes,
    List<String>? availableColors,
  }) {
    final cartController = Get.find<CartController>();
    
    // Use provided lists or defaults
    final sizes = availableSizes ?? ['S', 'M', 'L', 'XL'];
    final colors = availableColors ?? ['Black', 'White', 'Blue', 'Red', 'Green'];
    
    // Skip dialog if no size/color options
    final needsSizeSelection = sizes.isNotEmpty;
    final needsColorSelection = colors.isNotEmpty;
    
    if (!needsSizeSelection && !needsColorSelection) {
      // Add directly to cart without dialog
      cartController.quickAddToCart(
        productId: product['id'].toString(),
        productName: product['name'],
        productPrice: product['price'].toDouble(),
        productImage: product['image'],
        productBrand: product['brand'] ?? 'Unknown',
        productSize: null,
        productColor: null,
      );
      
      Get.snackbar(
        'Added to Cart',
        '${product['name']} added successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    
    String? selectedSize = needsSizeSelection ? null : 'One Size';
    String? selectedColor = needsColorSelection ? null : 'Default';
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            product['name'],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      product['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image, size: 48);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Price
                Text(
                  '\$${product['price']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: TColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Size Selection
                if (needsSizeSelection) ...[
                  const Text(
                    'Select Size:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: sizes.map((size) {
                      final isSelected = selectedSize == size;
                      return ChoiceChip(
                        label: Text(size),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedSize = selected ? size : null;
                          });
                        },
                        selectedColor: TColors.primary,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                
                // Color Selection
                if (needsColorSelection) ...[
                  const Text(
                    'Select Color:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: colors.map((color) {
                      final isSelected = selectedColor == color;
                      return ChoiceChip(
                        label: Text(color),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedColor = selected ? color : null;
                          });
                        },
                        selectedColor: TColors.primary,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: (selectedSize != null && selectedColor != null)
                  ? () {
                      cartController.quickAddToCart(
                        productId: product['id'].toString(),
                        productName: product['name'],
                        productPrice: product['price'].toDouble(),
                        productImage: product['image'],
                        productBrand: product['brand'] ?? 'Unknown',
                        productSize: selectedSize,
                        productColor: selectedColor,
                      );
                      
                      Navigator.pop(context);
                      
                      Get.snackbar(
                        'Added to Cart',
                        '${product['name']} ($selectedColor, $selectedSize) added to cart',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 2),
                        backgroundColor: TColors.primary,
                        colorText: Colors.white,
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}