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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
      decoration: BoxDecoration(
        color: backgroundColor ?? TColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
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
          Align(
            alignment: Alignment.topCenter,
            child: child,
          ),
        ],
      ),
    );
  }
}
