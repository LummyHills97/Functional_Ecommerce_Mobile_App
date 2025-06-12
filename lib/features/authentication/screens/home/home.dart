import 'package:ecommerce_store/common/widgets/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_store/utils/constants/text_strings.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
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

TAppBar(

title: Column(

crossAxisAlignment: CrossAxisAlignment.start,

children: [

Text(

TTexts.homeAppbarTitle,

style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey)

 ),

Text(

TTexts.homeAppbarSubTitle,

style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)

 ),

 ],

 ),

actions: [

IconButton(

onPressed: () {},

icon: const Icon(Iconsax.shopping_bag, color: TColors.white)

 )

 ],

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