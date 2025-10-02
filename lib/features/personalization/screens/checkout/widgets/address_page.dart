import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final addresses = [
      "No. 5, Adewale Street, Lagos",
      "12 Allen Avenue, Ikeja",
      "45 Ring Road, Ibadan",
    ].obs;

    void showAddAddressDialog() {
      final TextEditingController addressController = TextEditingController();
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: isDark ? TColors.dark : Colors.white,
          title: Text(
            "Add New Address",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : TColors.dark,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: addressController,
                maxLines: 3,
                style: TextStyle(color: isDark ? Colors.white : TColors.dark),
                decoration: InputDecoration(
                  hintText: "Enter your full address",
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey[600] : Colors.grey[400],
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                    ),
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
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
                  fillColor: isDark ? Colors.grey[850] : Colors.grey[50],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: isDark ? Colors.white70 : TColors.dark,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (addressController.text.isNotEmpty) {
                  addresses.add(addressController.text);
                  cartController.selectedAddress.value = addressController.text;
                  Navigator.pop(context);
                  Get.back();
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Address added and selected'),
                      backgroundColor: TColors.primary,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text("Save Address"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Select Address",
          style: TextStyle(
            color: isDark ? Colors.white : TColors.dark,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_location_alt,
              color: isDark ? Colors.white : TColors.dark,
            ),
            onPressed: showAddAddressDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery Address',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : TColors.dark,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            
            Expanded(
              child: Obx(() => ListView.separated(
                itemCount: addresses.length,
                separatorBuilder: (context, index) => const SizedBox(height: TSizes.sm),
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  final isSelected = cartController.selectedAddress.value == address;
                  
                  return InkWell(
                    onTap: () {
                      cartController.selectedAddress.value = address;
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
                            padding: const EdgeInsets.all(TSizes.sm),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? TColors.primary.withOpacity(0.2)
                                  : (isDark ? Colors.grey[800] : Colors.grey[200]),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.location_on,
                              color: isSelected 
                                  ? TColors.primary
                                  : (isDark ? Colors.white70 : TColors.dark),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: TSizes.md),
                          Expanded(
                            child: Text(
                              address,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}