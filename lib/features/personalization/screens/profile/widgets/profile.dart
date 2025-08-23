import 'package:flutter/material.dart';
import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: const Text('Profile'),
        onLeadingPressed: () {
          Get.back();
        },
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Profile Content Here"),
            SizedBox(height: 20),
            Text("The back arrow should now change color based on theme!"),
          ],
        ),
      ),
    );
  }
}