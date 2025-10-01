// filepath: lib/widgets/t_grid_layout.dart
import 'package:flutter/material.dart';

class TGridLayout extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  const TGridLayout({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}