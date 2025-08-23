import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.actions,
    this.onLeadingPressed,
    this.showBackArrow = false,
  });

  final Widget? title;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? onLeadingPressed;
  final bool showBackArrow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: theme.appBarTheme.backgroundColor ?? theme.colorScheme.background,
      foregroundColor: theme.appBarTheme.foregroundColor ?? theme.colorScheme.onBackground,
      leading: showBackArrow
          ? IconButton(
              onPressed: onLeadingPressed ?? () => Get.back(),
              icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
            )
          : leadingIcon != null
              ? IconButton(
                  onPressed: onLeadingPressed,
                  icon: Icon(leadingIcon, color: theme.iconTheme.color),
                )
              : null,
      title: title,
      actions: actions,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
