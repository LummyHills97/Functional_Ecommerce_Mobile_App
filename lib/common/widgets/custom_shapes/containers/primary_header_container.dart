import 'package:ecommerce_store/common/widgets/custom_shapes/circular_container.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
    this.height = 320,
    this.backgroundColor,
  });

  final Widget child;
  final double height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TCustomCurvedEdgeWidget(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? TColors.primary,
        ),
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              // Background circular containers for design
              Positioned(
                top: -150,
                right: -250,
                child: TCircular(
                  width: 400,
                  height: 400,
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: TCircular(
                  width: 400,
                  height: 400,
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                ),
              ),
              // Main content passed as child
              child,
            ],
          ),
        ),
      ),
    );
  }
}