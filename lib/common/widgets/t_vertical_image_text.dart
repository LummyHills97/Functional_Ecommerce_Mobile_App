import 'package:flutter/material.dart';

class TVerticalImageText extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback? onTap;
  final double imageSize;
  final TextStyle? textStyle;

  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
    this.imageSize = 56,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(image, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}