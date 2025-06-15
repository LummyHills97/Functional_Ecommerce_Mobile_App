import 'package:flutter/material.dart';

class TCircular extends StatelessWidget {
  const TCircular({
    super.key,
    this.child,
    this.width = 480,
    this.height = 480,
    this.backgroundColor = Colors.transparent,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.showBackground = true,
    this.borderRadius = 400,
  });

  final Widget? child;
  final double width;
  final double height;
  final Color backgroundColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final bool showBackground;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: showBackground ? backgroundColor : null,
      ),
      child: child,
    );
  }
}