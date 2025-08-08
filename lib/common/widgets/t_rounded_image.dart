import 'package:flutter/material.dart';

class TRoundedImage extends StatelessWidget {
  final String imageUrl;
  final String? darkImageUrl; // Optional dark mode image
  final double width;
  final double height;
  final BoxFit fit;
  final double borderRadius;
  final Color? backgroundColor; // Background color for containers
  final bool isNetworkImage; // Toggle between asset and network images
  
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
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Use dark image if available and in dark mode, otherwise use regular image
    final String finalImageUrl = (isDarkMode && darkImageUrl != null) 
        ? darkImageUrl! 
        : imageUrl;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor ?? (isDarkMode 
            ? Theme.of(context).colorScheme.surfaceContainerHighest
            : Theme.of(context).colorScheme.surface),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
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

// Alternative approach: Using ColorFiltered for tinting
class TRoundedImageWithFilter extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final double borderRadius;
  final bool applyDarkFilter;
  
  const TRoundedImageWithFilter({
    super.key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    this.borderRadius = 8.0,
    this.applyDarkFilter = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    Widget imageWidget = Image.asset(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
    );

    // Apply dark filter if enabled and in dark mode
    if (applyDarkFilter && isDarkMode) {
      imageWidget = ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.3),
          BlendMode.darken,
        ),
        child: imageWidget,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageWidget,
    );
  }
}