
import 'package:ecommerce_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
        return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.light,
      child: Column(
        children: [
          Row(
            children: [

              // icon
              Icon(Iconsax.ship),
              SizedBox(width: TSizes.spaceBtwItems/2,),

              // status and date
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Processing',
                    style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary, fontWeightDelta: 1),
                    ),
                    Text('06 Oct 2025', style: Theme.of(context).textTheme.headlineSmall,)

                ],
              )
                        ],)
        ],),
    );
  }
}