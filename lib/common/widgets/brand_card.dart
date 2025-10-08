// filepath: lib/common/widgets/brand_card.dart
import 'package:flutter/material.dart';

class TBrandCard extends StatelessWidget {
  final Map<String, dynamic> brand;

  const TBrandCard({Key? key, required this.brand, required String brandName, required int productCount, required Null Function() onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            brand['logo'],
            height: 40,
          ),
          SizedBox(height: 8),
          Text(
            brand['name'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}