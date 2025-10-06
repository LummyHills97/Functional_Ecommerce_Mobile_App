
import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/t_rounded_image.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Sports'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Banner
              TRoundedImage(width: double.infinity, imageUrl: TImages.promoBanner4, applyImageRadius: true),
              SizedBox(height: TSizes.spaceBtwSections),

              // Sub-Categories
              Column(
                children: [
                  // Heading
                  TSectionHeading(title: 'Sports shirts', onPressed: () {
                    
                  },
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2)
                ],)
            ],
          )
          ),
      )
    );
  }
} 