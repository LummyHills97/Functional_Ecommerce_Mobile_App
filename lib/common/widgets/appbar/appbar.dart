// appbar.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    // Force theme detection using multiple methods
    final isDark = Get.isDarkMode || 
                   Theme.of(context).brightness == Brightness.dark ||
                   MediaQuery.of(context).platformBrightness == Brightness.dark;
    
    // Direct color assignment based on theme
    final backgroundColor = isDark ? const Color(0xFF121212) : Colors.white;
    final iconColor = isDark ? Colors.white : Colors.black87;
    final textColor = isDark ? Colors.white : Colors.black87;
    
    // Title text style with direct color assignment
    final titleTextStyle = TextStyle(
      color: textColor,
      fontSize: 18, 
      fontWeight: FontWeight.w600,
    );

    // Set status bar brightness for correct icons
    SystemUiOverlayStyle overlayStyle = isDark
        ? SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          )
        : SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          );

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      title: title != null 
          ? DefaultTextStyle(
              style: titleTextStyle,
              child: title!,
            )
          : null,
      actions: actions,
      leading: showBackArrow
          ? IconButton(
              onPressed: onLeadingPressed ?? () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: iconColor,
                size: 24,
              ),
            )
          : leadingIcon != null
              ? IconButton(
                  onPressed: onLeadingPressed,
                  icon: Icon(leadingIcon, color: iconColor),
                )
              : null,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}