import 'package:ecommerce_store/common/widgets/t_vertical_image_text.dart';
import 'package:ecommerce_store/features/authentication/screens/sub_category/sub_categories.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          TVerticalImageText(
            image: TImages.shoeIcon,
            title: 'Shoes',
            onTap: () => Get.to(() => const SubCategoriesScreen(categoryName: 'Shoes')),
          ),
          TVerticalImageText(
            image: TImages.sportIcon,
            title: 'Sports',
            onTap: () => Get.to(() => const SubCategoriesScreen(categoryName: 'Sports')),
          ),
          TVerticalImageText(
            image: TImages.electronicsIcon,
            title: 'Electronics',
            onTap: () => Get.to(() => const SubCategoriesScreen(categoryName: 'Electronics')),
          ),
          TVerticalImageText(
            image: TImages.clothIcon,
            title: 'Fashion',
            onTap: () => Get.to(() => const SubCategoriesScreen(categoryName: 'Fashion')),
          ),
          TVerticalImageText(
            image: TImages.furnitureIcon,
            title: 'Furniture',
            onTap: () => Get.to(() => const SubCategoriesScreen(categoryName: 'Furniture')),
          ),
        ],
      ),
    );
  }
}