import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/features/personalization/controllers/address%20Controller/address_controller.dart';
import 'package:ecommerce_store/features/personalization/screens/address/widgets/add_new_address.dart';
import 'package:ecommerce_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => Column(
              children: [
                // Check if there are addresses
                if (controller.allAddresses.isEmpty)
                  // Empty state
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Icon(
                          Iconsax.location,
                          size: 100,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        Text(
                          'No addresses added yet',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),
                        Text(
                          'Add your first address to get started',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  // Address list
                  ...controller.allAddresses.map((address) => TSingleAddress(
                    address: address,
                    onTap: () => controller.selectAddress(address),
                  )).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}