import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/t_circular_image.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: const Text('Profile'),
        onLeadingPressed: () => Get.back(),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: TSizes.spaceBtwSections),
            
            // Profile Picture Section
            _ProfilePictureSection(),
            
            SizedBox(height: TSizes.spaceBtwSections),
            
            // Personal Information Section Header
            Align(
              alignment: Alignment.centerLeft,
              child: _SectionHeader(
                title: 'Personal Information',
                icon: Icons.person_outline,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            
            // Profile Information Section
            _ProfileInfoSection(),
            
            SizedBox(height: TSizes.spaceBtwSections),
            
            // Account Settings Section Header
            Align(
              alignment: Alignment.centerLeft,
              child: _SectionHeader(
                title: 'Account Settings',
                icon: Icons.settings_outlined,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            
            // Profile Actions Section
            _ProfileActionsSection(),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems / 2),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            margin: const EdgeInsets.only(left: TSizes.spaceBtwItems),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfilePictureSection extends StatelessWidget {
  const _ProfilePictureSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            TCircularImage(
              image: 'assets/images/content/user.png',
              width: 100,
              height: 100,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text(
          'Change Profile Picture',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ProfileInfoSection extends StatelessWidget {
  const _ProfileInfoSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Name Field
        _ProfileInfoTile(
          icon: Icons.person_outline,
          title: 'Full Name',
          subtitle: 'John Doe',
          onTap: () {
            // Navigate to edit name
          },
        ),
        
        const SizedBox(height: TSizes.spaceBtwItems),
        
        // Email Field
        _ProfileInfoTile(
          icon: Icons.email_outlined,
          title: 'Email',
          subtitle: 'john.doe@example.com',
          onTap: () {
            // Navigate to edit email
          },
        ),
        
        const SizedBox(height: TSizes.spaceBtwItems),
        
        // Phone Field
        _ProfileInfoTile(
          icon: Icons.phone_outlined,
          title: 'Phone Number',
          subtitle: '+1 234 567 8900',
          onTap: () {
            // Navigate to edit phone
          },
        ),
        
        const SizedBox(height: TSizes.spaceBtwItems),
        
        // Date of Birth Field
        _ProfileInfoTile(
          icon: Icons.calendar_today_outlined,
          title: 'Date of Birth',
          subtitle: 'January 1, 1990',
          onTap: () {
            // Navigate to edit DOB
          },
        ),
      ],
    );
  }
}

class _ProfileInfoTile extends StatelessWidget {
  const _ProfileInfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          Icons.edit_outlined,
          color: Colors.grey[400],
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }
}

class _ProfileActionsSection extends StatelessWidget {
  const _ProfileActionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Security Settings
        _buildActionButton(
          context: context,
          icon: Icons.security_outlined,
          title: 'Security Settings',
          subtitle: 'Password, 2FA, and more',
          onTap: () {
            // Navigate to security settings
          },
        ),
        
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        
        // Privacy Settings
        _buildActionButton(
          context: context,
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Settings',
          subtitle: 'Control your privacy preferences',
          onTap: () {
            // Navigate to privacy settings
          },
        ),
        
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        
        // Notifications
        _buildActionButton(
          context: context,
          icon: Icons.notifications_outlined,
          title: 'Notification Settings',
          subtitle: 'Manage your notifications',
          onTap: () {
            // Navigate to notification settings
          },
        ),
        
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        
        // Delete Account
        _buildActionButton(
          context: context,
          icon: Icons.delete_outline,
          title: 'Delete Account',
          subtitle: 'Permanently delete your account',
          isDestructive: true,
          onTap: () {
            _showDeleteAccountDialog(context);
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: isDestructive 
            ? Border.all(color: Colors.red.withOpacity(0.2))
            : null,
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive 
                ? Colors.red.withOpacity(0.1)
                : Theme.of(context).primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isDestructive 
                ? Colors.red
                : Theme.of(context).primaryColor,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDestructive ? Colors.red : null,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey[400],
        ),
        onTap: onTap,
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle account deletion
                Get.snackbar(
                  'Account Deleted',
                  'Your account has been scheduled for deletion.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}