import "package:flutter/material.dart";

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    required this.iconColor,
    this.itemCount = 0,
    this.badgeColor = Colors.red,
    this.badgeTextColor = Colors.white,
    this.iconSize = 24.0,
  });

  final Color iconColor;
  final VoidCallback onPressed;
  final int itemCount;
  final Color badgeColor;
  final Color badgeTextColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.shopping_bag_outlined,
            color: iconColor,
            size: iconSize,
          ),
        ),
        if (itemCount > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                itemCount > 99 ? '99+' : itemCount.toString(),
                style: TextStyle(
                  color: badgeTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}