import 'package:flutter/material.dart';

class TCircular extends StatelessWidget {
  const TCircular({
    super.key,
    this.child,
    this.width = 100,
    this.height = 100,
    this.backgroundColor = Colors.blue,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.showBackground = true,
    this.borderRadius = 50,
    this.onTap,
  });

  final Widget? child;
  final double width;
  final double height;
  final Color backgroundColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final bool showBackground;
  final double borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
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

    // Add tap functionality if needed
    if (onTap != null) {
      container = GestureDetector(
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }

  // Factory constructor for avatar
  static TCircular avatar({
    Key? key,
    Widget? child,
    double size = 48,
    Color? backgroundColor,
    VoidCallback? onTap,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) {
    return TCircular(
      key: key,
      child: child,
      width: size,
      height: size,
      backgroundColor: backgroundColor ?? Colors.grey,
      onTap: onTap,
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      borderRadius: size / 2,
    );
  }

  // Factory constructor for icon button
  static TCircular iconButton({
    Key? key,
    required Widget icon,
    required VoidCallback onTap,
    double size = 48,
    Color? backgroundColor,
    EdgeInsetsGeometry? margin,
  }) {
    return TCircular(
      key: key,
      child: icon,
      width: size,
      height: size,
      backgroundColor: backgroundColor ?? Colors.white,
      onTap: onTap,
      margin: margin ?? EdgeInsets.zero,
      borderRadius: size / 2,
    );
  }

  // Factory constructor for badge
  static TCircular badge({
    Key? key,
    Widget? child,
    double size = 20,
    Color backgroundColor = Colors.red,
    EdgeInsetsGeometry? margin,
  }) {
    return TCircular(
      key: key,
      child: child,
      width: size,
      height: size,
      backgroundColor: backgroundColor,
      margin: margin ?? EdgeInsets.zero,
      borderRadius: size / 2,
    );
  }
}

// Simple usage examples
class TCircularExamples extends StatelessWidget {
  const TCircularExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TCircular Examples')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic usage
            const Text('Basic Circular Container:'),
            const SizedBox(height: 8),
            const TCircular(
              width: 100,
              height: 100,
              backgroundColor: Colors.blue,
              child: Icon(Icons.star, color: Colors.white, size: 32),
            ),
            
            const SizedBox(height: 24),
            
            // Avatar
            const Text('Avatar:'),
            const SizedBox(height: 8),
            TCircular.avatar(
              size: 60,
              backgroundColor: Colors.grey,
              child: const Icon(Icons.person, size: 32, color: Colors.white),
              onTap: () => print('Avatar tapped'),
            ),
            
            const SizedBox(height: 24),
            
            // Icon Button
            const Text('Icon Button:'),
            const SizedBox(height: 8),
            TCircular.iconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onTap: () => print('Heart tapped'),
              backgroundColor: Colors.white,
            ),
            
            const SizedBox(height: 24),
            
            // Badge
            const Text('Badge:'),
            const SizedBox(height: 8),
            Stack(
              children: [
                const Icon(Icons.notifications, size: 32),
                Positioned(
                  right: 0,
                  top: 0,
                  child: TCircular.badge(
                    size: 16,
                    child: const Text('3', 
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}