import 'package:ecommerce_store/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
    this.userName = 'User',
    this.cartItemCount = 0,
    this.onCartPressed,
  });

  final String userName;
  final int cartItemCount;
  final VoidCallback? onCartPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Welcome Text Section
            _buildWelcomeSection(context),
            
            // Cart Icon with Badge
            _buildCartIcon(context),
          ],
        ),
      ),
    );
  }

  /// Welcome section with greeting and user name
  Widget _buildWelcomeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getGreeting(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: TColors.grey,
          ),
        ),
        Text(
          userName,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: TColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// Cart icon with animated badge
  Widget _buildCartIcon(BuildContext context) {
    return TCartCounterIcon(
      onPressed: onCartPressed ?? () => _defaultCartAction(context),
      itemCount: cartItemCount,
      iconColor: TColors.white,
    );
  }

  /// Get appropriate greeting based on time of day
  String _getGreeting() {
    final hour = DateTime.now().hour;
    
    if (hour < 12) {
      return 'Good morning for shopping';
    } else if (hour < 17) {
      return 'Good afternoon for shopping';
    } else {
      return 'Good evening for shopping';
    }
  }

  /// Default cart action when no callback is provided
  void _defaultCartAction(BuildContext context) {
    debugPrint('Cart pressed - navigating to cart screen');
    // You can add default navigation here
    // Navigator.pushNamed(context, '/cart');
  }
}