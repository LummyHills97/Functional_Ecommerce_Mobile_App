import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Popular Products'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown for sorting or filtering (optional)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.sort),
                  hintText: 'Sort by',
                ),
                items: const [
                  DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High')),
                  DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low')),
                  DropdownMenuItem(value: 'newest', child: Text('Newest')),
                ],
                onChanged: (value) {
                  // TODO: handle sorting
                },
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Example placeholder for product grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: TSizes.spaceBtwItems,
                  crossAxisSpacing: TSizes.spaceBtwItems,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(TSizes.md),
                    ),
                    child: Center(child: Text('Product ${index + 1}')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
