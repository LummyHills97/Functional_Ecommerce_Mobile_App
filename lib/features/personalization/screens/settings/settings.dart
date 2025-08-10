import 'package:flutter/material.dart';
import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context)
        .textTheme
        .headlineMedium
        ?.apply(color: TColors.white);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with shorter height
            SizedBox(
              height: kToolbarHeight + 90, // AppBar height + padding
              child: TPrimaryHeaderContainer(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: TAppBar(
                      title: Text(
                        'ACCOUNT',
                        style: headlineStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // You can add the rest of your settings content below
          ],
        ),
      ),
    );
  }
}
