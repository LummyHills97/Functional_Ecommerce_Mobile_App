

import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            TPrimaryHeaderContainer(child: Column(
               children: [
                Text('ACCOUNT')
               ],
            )),
          ],
        ),
      )

    );
  }
}