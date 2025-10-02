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
    // get status bar height so we can extend behind it
    final double statusBar = MediaQuery.of(context).padding.top;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: Container(
        width: double.infinity,
        // ensure the header is at least `height` + statusBar so blue covers top
        constraints: BoxConstraints(minHeight: height + statusBar),
        // add top padding that includes the status bar so content is not under the notch
        padding: EdgeInsets.only(top: statusBar + 12, left: 0, right: 0, bottom: 16),
        decoration: BoxDecoration(
          color: backgroundColor ?? TColors.primary,
        ),
        child: Stack(
          children: [
            // Decorative circular backgrounds
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

            // Your main content inside the header
            child,
          ],
        ),
      ),
    );
  }
}
