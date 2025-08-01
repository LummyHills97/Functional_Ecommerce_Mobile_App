import 'package:flutter/material.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/text_strings.dart';
import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/products.cart/cart_menu_icon.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: TColors.grey),
          ),
          Text(
            TTexts.homeAppbarSubTitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: TColors.white),
          ),
        ],
      ),
      actions: [
        TCartCounterIcon(
          onPressed: () {}, // Replace with real logic
          iconColor: TColors.white,
        ),
      ],
    );
  }
}
