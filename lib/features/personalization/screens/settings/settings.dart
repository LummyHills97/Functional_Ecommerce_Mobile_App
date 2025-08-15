import 'package:flutter/material.dart';
import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme; // Easy access to text styles

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
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace,
                    ),
                    child: TAppBar(
                      title: Text(
                        'ACCOUNT',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: TColors.white, // Using your constants
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Example settings options
            const SizedBox(height: TSizes.spaceBtwSections),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profile'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to Profile
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Preferences'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to Preferences
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
