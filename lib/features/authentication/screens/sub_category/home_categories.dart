
import 'package:ecommerce_store/common/widgets/t_vertical_image_text.dart';
import 'package:ecommerce_store/features/authentication/screens/sub_category/sub_categories.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // Set a valid double value for height
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return TVerticalImageText(
            image: TImages.shoeIcon,
            title: 'Shoes',
            onTap: () => Get.to(() => SubCategoriesScreen()),
          );
        },
      ),
    );
  }
}