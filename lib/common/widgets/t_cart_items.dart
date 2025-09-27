import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/features/personalization/models/cart_item.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  final CartItem item;
  final bool showQuantityControls;
  final bool showRemoveButton;
  final VoidCallback? onRemove;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? borderRadius;

  const TCartItems({
    super.key,
    required this.item,
    this.showQuantityControls = true,
    this.showRemoveButton = true,
    this.onRemove,
    this.onIncrease,
    this.onDecrease,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? cs.surface,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          _buildProductImage(cs),
          const SizedBox(width: 16),
          
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductName(tt, cs),
                const SizedBox(height: 4),
                _buildProductVariant(tt, cs),
                const SizedBox(height: 8),
                _buildPriceAndQuantity(tt, cs, cartController),
              ],
            ),
          ),
          
          // Remove Button
          if (showRemoveButton) _buildRemoveButton(cs),
        ],
      ),
    );
  }

  Widget _buildProductImage(ColorScheme cs) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: cs.surfaceVariant,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: item.image.startsWith('assets/') 
            ? Image.asset(
                item.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: cs.surfaceVariant,
                    child: Icon(
                      Icons.image,
                      color: cs.onSurfaceVariant,
                      size: 32,
                    ),
                  );
                },
              )
            : Image.network(
                item.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: cs.surfaceVariant,
                    child: Icon(
                      Icons.image,
                      color: cs.onSurfaceVariant,
                      size: 32,
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildProductName(TextTheme tt, ColorScheme cs) {
    return Text(
      item.name,
      style: tt.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: cs.onSurface,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProductVariant(TextTheme tt, ColorScheme cs) {
    return Text(
      '${item.color} • ${item.size}',
      style: tt.bodySmall?.copyWith(
        color: cs.onSurfaceVariant,
      ),
    );
  }

  Widget _buildPriceAndQuantity(TextTheme tt, ColorScheme cs, CartController cartController) {
    return Row(
      children: [
        // Price
        Flexible(
          child: Text(
            '\$${item.price.toStringAsFixed(2)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: tt.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: cs.primary,
            ),
          ),
        ),
        
        if (showQuantityControls) ...[
          const Spacer(),
          // Quantity Controls
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildQuantityButton(
                Icons.remove,
                () {
                  if (onDecrease != null) {
                    onDecrease!();
                  } else {
                    cartController.decrementQuantity(item.id);
                  }
                },
                cs,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: cs.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${item.quantity}',
                  style: tt.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
              ),
              _buildQuantityButton(
                Icons.add,
                () {
                  if (onIncrease != null) {
                    onIncrease!();
                  } else {
                    cartController.incrementQuantity(item.id);
                  }
                },
                cs,
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed, ColorScheme cs) {
    return Container(
      decoration: BoxDecoration(
        color: cs.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 16),
        color: cs.primary,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      ),
    );
  }

  Widget _buildRemoveButton(ColorScheme cs) {
    return IconButton(
      onPressed: () {
        if (onRemove != null) {
          onRemove!();
        } else {
          final CartController cartController = Get.find<CartController>();
          cartController.removeFromCart(item.id);
        }
      },
      icon: Icon(Icons.close, color: cs.onSurfaceVariant),
      style: IconButton.styleFrom(
        backgroundColor: cs.surfaceVariant,
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}

// Extension widget for simplified usage
class TCartItemsList extends StatelessWidget {
  final List<CartItem> items;
  final EdgeInsetsGeometry? padding;
  final double spacing;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const TCartItemsList({
    super.key,
    required this.items,
    this.padding,
    this.spacing = 16.0,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: spacing),
      itemBuilder: (context, index) {
        return TCartItems(item: items[index]);
      },
    );
  }
}

// Usage Examples:
/*
// Basic usage
TCartItems(item: cartItem)

// Custom styling
TCartItems(
  item: cartItem,
  backgroundColor: Colors.grey[50],
  borderRadius: 12,
  padding: EdgeInsets.all(12),
)

// Without quantity controls (for order history, etc.)
TCartItems(
  item: cartItem,
  showQuantityControls: false,
  showRemoveButton: false,
)

// With custom callbacks
TCartItems(
  item: cartItem,
  onRemove: () => customRemoveFunction(),
  onIncrease: () => customIncreaseFunction(),
  onDecrease: () => customDecreaseFunction(),
)

// List of cart items
TCartItemsList(
  items: cartController.cartItems,
  padding: EdgeInsets.all(16),
  spacing: 12,
)
*/