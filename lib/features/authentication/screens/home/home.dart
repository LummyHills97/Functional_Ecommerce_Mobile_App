import 'package:ecommerce_store/common/widgets/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_store/common/widgets/home_appbar.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/text_strings.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                  
                  // Search Bar
                  Container(
                    width: TDeviceUtils.getScreenWidth(context),
                    margin: EdgeInsets.all(TSizes.md),
                    padding: EdgeInsets.all(TSizes.md),
                    decoration: BoxDecoration(
                      color: TColors.white,
                      borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                      border: Border.all(color: TColors.grey),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.search_normal,
                          color: TColors.darkerGrey,
                          size: 20,
                        ),
                        SizedBox(width: TSizes.spaceBtwItems),
                        Text(
                          'Search in Store',
                          style: TextStyle(
                            color: TColors.darkerGrey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            
            // Body content
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Add your body content here
                  Text('Body Content Goes Here'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}