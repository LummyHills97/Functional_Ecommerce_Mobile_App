import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    required this.selectedAddress,
    this.onTap,
  });

  final bool selectedAddress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        width: double.infinity,
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: selectedAddress
            ? TColors.primary.withOpacity(0.5)
            : Colors.transparent,
        borderColor: selectedAddress
            ? Colors.transparent
            : dark
                ? TColors.darkerGrey
                : TColors.grey,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 0,
              child: Icon(
                selectedAddress ? Iconsax.tick_circle5 : null,
                color: selectedAddress
                    ? dark
                        ? TColors.light
                        : TColors.dark.withOpacity(0.6)
                    : null,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: TSizes.sm / 2),
                const Text(
                  '(+234) 456 7890',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: TSizes.sm / 2),
                const Text(
                  '82356 Timmy Coves, South Liana, Maine, 87665, USA',
                  softWrap: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// TRoundedContainer Widget (you'll need this too)
class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.showBorder = false,
    this.radius = TSizes.cardRadiusLg,
    this.backgroundColor = TColors.white,
    this.borderColor = TColors.borderPrimary,
    this.onTap,
  });

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null,
        ),
        child: child,
      ),
    );
  }
}