import 'package:flutter/material.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140), // Increased height to prevent overflow
        child: AppBar(
          backgroundColor: TColors.primary,
          elevation: 0,
          centerTitle: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Text(
                    'Account',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // User info row
                  Row(
                    children: [
                      // User image
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/content/user.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback to icon if image fails to load
                              return Container(
                                color: Colors.white.withOpacity(0.2),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // User details with edit functionality
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'LummyHills', 
                              style: textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'lummyhills97@email.com', // Replace with actual email
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.white.withOpacity(0.8),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // Beautiful Edit Icon
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              // Handle edit profile
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Edit profile functionality'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        children: [
          // Account Settings Section Header
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Account Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: TColors.primary,
              ),
            ),
          ),
          
          ListTile(
            leading: Icon(Icons.location_on_outlined, color: Colors.blue),
            title: const Text('My Address'),
            subtitle: const Text('Manage your shipping and billing addresses'),
            onTap: () {
              // Navigate to address management
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart_outlined, color: Colors.blue),
            title: const Text('My Cart'),
            subtitle: const Text('View and manage items in your cart'),
            onTap: () {
              // Navigate to cart
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined, color: Colors.blue),
            title: const Text('My Order'),
            subtitle: const Text('Track your current and past orders'),
            onTap: () {
              // Navigate to orders
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.account_balance_outlined, color: Colors.blue),
            title: const Text('Bank Account'),
            subtitle: const Text('Manage your payment methods and cards'),
            onTap: () {
              // Navigate to bank account settings
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.local_offer_outlined, color: Colors.blue),
            title: const Text('My Coupon'),
            subtitle: const Text('View available coupons and discounts'),
            onTap: () {
              // Navigate to coupons
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.notifications_outlined, color: Colors.blue),
            title: const Text('Notification'),
            subtitle: const Text('Set any kind of notification message'),
            onTap: () {
              // Navigate to notification settings
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.settings_outlined, color: Colors.blue),
            title: const Text('Account Settings'),
            subtitle: const Text('Manage your account preferences'),
            onTap: () {
              // Navigate to account settings
            },
          ),
          
          const SizedBox(height: 24),
          
          // App Settings Section Header
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'App Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: TColors.primary,
              ),
            ),
          ),
          
          ListTile(
            leading: Icon(Icons.cloud_download_outlined, color: Colors.blue),
            title: const Text('Load Data'),
            subtitle: const Text('Automatically load content and updates'),
            onTap: () {
              // Navigate to load data settings
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.location_searching_outlined, color: Colors.blue),
            title: const Text('Geolocation'),
            subtitle: const Text('Allow app to access your location'),
            trailing: Switch(
              value: true, // You can manage this state with StatefulWidget
              onChanged: (value) {
                // Handle geolocation toggle
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.security_outlined, color: Colors.blue),
            title: const Text('Safe Mode'),
            subtitle: const Text('Enable additional security features'),
            trailing: Switch(
              value: false, // You can manage this state with StatefulWidget
              onChanged: (value) {
                // Handle safe mode toggle
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.hd_outlined, color: Colors.blue),
            title: const Text('HD Image Quality'),
            subtitle: const Text('Download and display high-definition images'),
            trailing: Switch(
              value: true, // You can manage this state with StatefulWidget
              onChanged: (value) {
                // Handle HD image quality toggle
              },
            ),
          ),
        ],
      ),
    );
  }
}