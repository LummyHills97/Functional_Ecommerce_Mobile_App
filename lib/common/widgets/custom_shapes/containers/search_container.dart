import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/device/device_utility.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    this.onTap,
    this.text = 'Search in Store',
  });

  final VoidCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: TDeviceUtils.getScreenWidth(context),
        margin: const EdgeInsets.all(TSizes.md),
        padding: const EdgeInsets.symmetric(
          vertical: TSizes.sm,
          horizontal: TSizes.md,
        ),
        decoration: BoxDecoration(
          color: isDark ? TColors.dark : TColors.light,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          border: Border.all(
            color: isDark ? TColors.darkerGrey : TColors.grey,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Iconsax.search_normal,
              color: isDark ? TColors.lightGrey : TColors.darkerGrey,
              size: 20,
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              text,
              style: TextStyle(
                color: isDark ? TColors.lightGrey : TColors.darkerGrey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
