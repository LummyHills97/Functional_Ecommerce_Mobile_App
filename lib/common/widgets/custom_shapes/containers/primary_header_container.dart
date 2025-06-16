import 'package:ecommerce_store/common/widgets/custom_shapes/containers/circular_container.dart';
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
    return ClipPath(
      clipper: InwardCurveClipper(),
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          color: backgroundColor ?? TColors.primary,
        ),
        child: Stack(
          children: [
            // Decorative circular shapes
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

            // Main child content
            child,
          ],
        ),
      ),
    );
  }
}

class InwardCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Left to bottom left
    path.lineTo(0, size.height - 40);

    // Inward curve toward bottom center
    path.quadraticBezierTo(
      size.width / 2, size.height + 40, // Dip inward
      size.width, size.height - 40,
    );

    // Bottom right to top right
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
