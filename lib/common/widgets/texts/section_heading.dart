import 'package:flutter/material.dart';

class TSectionHeading extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final Color? textColor;
  final bool showActionButton;
  final VoidCallback? onPressed;
  final TextStyle? titleStyle;
  final TextStyle? buttonStyle;

  const TSectionHeading({
    super.key,
    required this.title,
    this.buttonTitle = 'View all',
    this.textColor,
    this.showActionButton = true,
    this.onPressed,
    this.titleStyle,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTitleStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
      color: textColor ?? Theme.of(context).colorScheme.onBackground,
      fontWeight: FontWeight.w600,
    );

    final defaultButtonStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: titleStyle ?? defaultTitleStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (showActionButton)
            TextButton(
              onPressed: onPressed,
              child: Text(
                buttonTitle,
                style: buttonStyle ?? defaultButtonStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}