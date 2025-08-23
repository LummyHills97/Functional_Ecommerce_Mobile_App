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
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(
              onPressed: onLeadingPressed ?? () => Get.back(),
              icon: const Icon(Icons.arrow_back),
            )
          : leadingIcon != null
              ? IconButton(
                  onPressed: onLeadingPressed,
                  icon: Icon(leadingIcon),
                )
              : null,
      title: title,
      actions: actions,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
