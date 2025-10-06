import 'package:flutter/material.dart';

class TRoundedImage extends StatelessWidget {
  final String imageUrl;
  final String? darkImageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final double borderRadius;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final bool applyImageRadius; 

  const TRoundedImage({
    super.key,
    required this.imageUrl,
    this.darkImageUrl,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    this.borderRadius = 8.0,
    this.backgroundColor,
    this.isNetworkImage = false,
    this.applyImageRadius = true, 
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final String finalImageUrl = (isDarkMode && darkImageUrl != null)
        ? darkImageUrl!
        : imageUrl;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: applyImageRadius
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.zero,
        color: backgroundColor ??
            (isDarkMode
                ? Theme.of(context).colorScheme.surfaceContainerHighest
                : Theme.of(context).colorScheme.surface),
      ),
      child: ClipRRect(
        borderRadius: applyImageRadius
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.zero,
        child: isNetworkImage
            ? Image.network(
                finalImageUrl,
                width: width,
                height: height,
                fit: fit,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: width,
                    height: height,
                    color: isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[300],
                    child: Icon(
                      Icons.error_outline,
                      color: isDarkMode ? Colors.white54 : Colors.black54,
                    ),
                  );
                },
              )
            : Image.asset(
                finalImageUrl,
                width: width,
                height: height,
                fit: fit,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: width,
                    height: height,
                    color: isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[300],
                    child: Icon(
                      Icons.error_outline,
                      color: isDarkMode ? Colors.white54 : Colors.black54,
                    ),
                  );
                },
              ),
      ),
    );
  }
}