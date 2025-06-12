import 'package:ecommerce_store/common/widgets/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar()

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}