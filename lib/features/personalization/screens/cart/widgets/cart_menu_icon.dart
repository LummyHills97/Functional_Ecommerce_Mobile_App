import 'package:flutter/material.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';

class TCartCounterIcon extends StatefulWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    this.itemCount = 0,
    this.iconColor = TColors.white,
    this.counterColor = TColors.black,
    this.counterTextColor = TColors.white,
    this.showZero = false,
    this.iconSize = 28.0,
    this.counterSize = 18.0,
  });

  /// Callback function when cart icon is pressed
  final VoidCallback onPressed;
  
  /// Number of items in cart
  final int itemCount;
  
  /// Color of the shopping bag icon
  final Color iconColor;
  
  /// Background color of the counter badge
  final Color counterColor;
  
  /// Text color of the counter
  final Color counterTextColor;
  
  /// Whether to show the badge when count is 0
  final bool showZero;
  
  /// Size of the cart icon
  final double iconSize;
  
  /// Size of the counter badge
  final double counterSize;

  @override
  State<TCartCounterIcon> createState() => _TCartCounterIconState();
}

class _TCartCounterIconState extends State<TCartCounterIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticInOut,
    ));
  }

  @override
  void didUpdateWidget(TCartCounterIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Trigger animation when item count changes
    if (oldWidget.itemCount != widget.itemCount) {
      _animateCounterChange();
    }
  }

  void _animateCounterChange() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _triggerTapAnimation();
        widget.onPressed();
      },
      borderRadius: BorderRadius.circular(24),
      child: AnimatedBuilder(
        animation: _bounceAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _bounceAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Cart Icon
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: widget.iconColor,
                    size: widget.iconSize,
                  ),
                  
                  // Counter Badge
                  if (widget.itemCount > 0 || widget.showZero)
                    Positioned(
                      right: -6,
                      top: -6,
                      child: AnimatedBuilder(
                        animation: _scaleAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: _buildCounterBadge(),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCounterBadge() {
    final displayCount = widget.itemCount > 99 ? '99+' : widget.itemCount.toString();
    final badgeWidth = widget.itemCount > 99 ? widget.counterSize + 6 : widget.counterSize;
    
    return Container(
      width: badgeWidth,
      height: widget.counterSize,
      decoration: BoxDecoration(
        color: widget.counterColor,
        borderRadius: BorderRadius.circular(widget.counterSize / 2),
        border: Border.all(
          color: widget.iconColor == TColors.white ? TColors.white : Colors.transparent,
          width: widget.iconColor == TColors.white ? 1.5 : 0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          displayCount,
          style: TextStyle(
            color: widget.counterTextColor,
            fontSize: widget.itemCount > 99 ? 10 : 11,
            fontWeight: FontWeight.w600,
            height: 1.0,
          ),
        ),
      ),
    );
  }

  void _triggerTapAnimation() {
    _animationController.reset();
    _animationController.forward().then((_) {
      if (mounted) {
        _animationController.reverse();
      }
    });
  }
}

// Alternative simplified version without animations (if you prefer)
class TCartCounterIconSimple extends StatelessWidget {
  const TCartCounterIconSimple({
    super.key,
    required this.onPressed,
    this.itemCount = 0,
    this.iconColor = TColors.white,
    this.counterColor = TColors.black,
    this.counterTextColor = TColors.white,
    this.showZero = false,
  });

  final VoidCallback onPressed;
  final int itemCount;
  final Color iconColor;
  final Color counterColor;
  final Color counterTextColor;
  final bool showZero;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              color: iconColor,
              size: 28,
            ),
            if (itemCount > 0 || showZero)
              Positioned(
                right: -6,
                top: -6,
                child: Container(
                  width: itemCount > 99 ? 24 : 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: counterColor,
                    borderRadius: BorderRadius.circular(9),
                    border: iconColor == TColors.white
                        ? Border.all(color: TColors.white, width: 1.5)
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      itemCount > 99 ? '99+' : itemCount.toString(),
                      style: TextStyle(
                        color: counterTextColor,
                        fontSize: itemCount > 99 ? 10 : 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}