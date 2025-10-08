import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/brands/brand_show_case.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    
    // All available brands with their categories and product counts
    final List<Map<String, dynamic>> brands = [
      {'name': 'Nike', 'category': 'sport', 'productCount': 3},
      {'name': 'Adidas', 'category': 'sport', 'productCount': 3},
      {'name': 'IKEA', 'category': 'furniture', 'productCount': 2},
      {'name': 'Ashley', 'category': 'furniture', 'productCount': 2},
      {'name': 'Samsung', 'category': 'electronics', 'productCount': 2},
      {'name': 'Acer', 'category': 'electronics', 'productCount': 3},
      {'name': 'Zara', 'category': 'clothes', 'productCount': 3},
      {'name': 'H&M', 'category': 'clothes', 'productCount': 3},
    ];

    return Scaffold(
      appBar: const TAppBar(
        title: Text('All Brands'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Heading
              const TSectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              
              // Brands Grid
              GridView.builder(
                itemCount: brands.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: TSizes.gridViewSpacing,
                  crossAxisSpacing: TSizes.gridViewSpacing,
                  mainAxisExtent: 80,
                ),
                itemBuilder: (context, index) {
                  final brand = brands[index];
                  final brandName = brand['name'].toString();
                  final productCount = brand['productCount'] as int;
                  final category = brand['category'].toString();
                  
                  return _buildBrandCard(
                    context,
                    brandName,
                    productCount,
                    category,
                    isDark,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandCard(
    BuildContext context,
    String brandName,
    int productCount,
    String category,
    bool isDark,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to brand showcase
        Get.to(() => BrandShowcase(
              brandName: brandName,
              category: category,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(TSizes.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: isDark ? TColors.darkGrey : TColors.grey,
          ),
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Brand Icon
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(TSizes.xs),
              decoration: BoxDecoration(
                color: isDark ? TColors.darkGrey : TColors.light,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.storefront,
                size: 24,
                color: TColors.primary,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            
            // Brand Name & Product Count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          brandName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: TSizes.xs / 2),
                      const Icon(
                        Icons.verified,
                        color: TColors.primary,
                        size: 16,
                      ),
                    ],
                  ),
                  Text(
                    '$productCount Products',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isDark ? TColors.grey : TColors.darkGrey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}