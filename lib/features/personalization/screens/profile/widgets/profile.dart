import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/t_circular_image.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Controllers for editable fields
  final TextEditingController _nameController = TextEditingController(text: 'Lummy Hills');
  final TextEditingController _emailController = TextEditingController(text: 'lummyhills@gmail.com');
  final TextEditingController _phoneController = TextEditingController(text: '+234 8123 456 7890');
  final TextEditingController _dobController = TextEditingController(text: 'January 1, 1880');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: const Text('Profile'),
        onLeadingPressed: () => Get.back(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: TSizes.spaceBtwSections),
            
            // Profile Picture Section
            const _ProfilePictureSection(),
            
            const SizedBox(height: TSizes.spaceBtwSections),
            
            // Personal Information Section Header
            const Align(
              alignment: Alignment.centerLeft,
              child: _SectionHeader(
                title: 'Personal Information',
                icon: Icons.person_outline,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            
            // Profile Information Section
            _ProfileInfoSection(
              nameController: _nameController,
              emailController: _emailController,
              phoneController: _phoneController,
              dobController: _dobController,
            ),
            
            const SizedBox(height: TSizes.spaceBtwSections),
            
            // Account Settings Section Header
            const Align(
              alignment: Alignment.centerLeft,
              child: _SectionHeader(
                title: 'Account Settings',
                icon: Icons.settings_outlined,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            
            // Profile Actions Section
            const _ProfileActionsSection(),
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
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 18,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems / 2),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16,
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
              width: 90,
              height: 90,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Text(
          'Change Profile Picture',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _ProfileInfoSection extends StatelessWidget {
  const _ProfileInfoSection({
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.dobController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController dobController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Name Field
        _ProfileInfoTile(
          icon: Icons.person_outline,
          title: 'Full Name',
          controller: nameController,
          onTap: () => _showEditDialog(context, 'Full Name', nameController),
        ),
        
        const SizedBox(height: TSizes.spaceBtwItems),
        
        // Email Field
        _ProfileInfoTile(
          icon: Icons.email_outlined,
          title: 'Email',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          onTap: () => _showEditDialog(context, 'Email', emailController, TextInputType.emailAddress),
        ),
        
        const SizedBox(height: TSizes.spaceBtwItems),
        
        // Phone Field
        _ProfileInfoTile(
          icon: Icons.phone_outlined,
          title: 'Phone Number',
          controller: phoneController,
          keyboardType: TextInputType.phone,
          onTap: () => _showEditDialog(context, 'Phone Number', phoneController, TextInputType.phone),
        ),
        
        const SizedBox(height: TSizes.spaceBtwItems),
        
        // Date of Birth Field
        _ProfileInfoTile(
          icon: Icons.calendar_today_outlined,
          title: 'Date of Birth',
          controller: dobController,
          onTap: () => _showDatePicker(context, dobController),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context, String title, TextEditingController controller, [TextInputType? keyboardType]) {
    final tempController = TextEditingController(text: controller.text);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit $title',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: tempController,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              labelText: title,
              labelStyle: const TextStyle(fontSize: 12),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(fontSize: 12)),
            ),
            TextButton(
              onPressed: () {
                controller.text = tempController.text;
                Navigator.of(context).pop();
                Get.snackbar(
                  'Updated',
                  '$title has been updated successfully',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );
              },
              child: const Text('Save', style: TextStyle(fontSize: 12)),
            ),
          ],
        );
      },
    );
  }

  void _showDatePicker(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      final months = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];
      controller.text = '${months[picked.month - 1]} ${picked.day}, ${picked.year}';
      Get.snackbar(
        'Updated',
        'Date of Birth has been updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }
}

class _ProfileInfoTile extends StatelessWidget {
  const _ProfileInfoTile({
    required this.icon,
    required this.title,
    required this.controller,
    required this.onTap,
    this.keyboardType,
  });

  final IconData icon;
  final String title;
  final TextEditingController controller;
  final VoidCallback onTap;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 18,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
            fontSize: 10,
          ),
        ),
        subtitle: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Text(
              controller.text,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            );
          },
        ),
        trailing: Icon(
          Icons.edit_outlined,
          color: Colors.grey[400],
          size: 18,
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
        borderRadius: BorderRadius.circular(10),
        border: isDestructive 
            ? Border.all(color: Colors.red.withOpacity(0.2))
            : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(6),
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
            size: 18,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDestructive ? Colors.red : null,
            fontSize: 13,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
            fontSize: 11,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey[400],
          size: 16,
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
          title: const Text(
            'Delete Account',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: TextStyle(fontSize: 13),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(fontSize: 12)),
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
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ],
        );
      },
    );
  }
}