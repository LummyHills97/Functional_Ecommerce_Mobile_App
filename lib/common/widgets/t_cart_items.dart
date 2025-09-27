import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/features/personalization/models/cart_item.dart';

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
    final cartController = Get.find<CartController>();
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
          _buildProductImage(cs),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBrand(tt, cs),
                const SizedBox(height: 2),
                _buildProductName(tt, cs),
                const SizedBox(height: 4),
                _buildProductVariant(tt, cs),
                const SizedBox(height: 8),
                _buildPriceAndQuantity(tt, cs, cartController),
              ],
            ),
          ),
          if (showRemoveButton) _buildRemoveButton(cs),
        ],
      ),
    );
  }

  // --- UI helpers ---

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
                errorBuilder: (_, __, ___) => _imagePlaceholder(cs),
              )
            : Image.network(
                item.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _imagePlaceholder(cs),
              ),
      ),
    );
  }

  Widget _imagePlaceholder(ColorScheme cs) {
    return Container(
      color: cs.surfaceVariant,
      child: Icon(Icons.image, color: cs.onSurfaceVariant, size: 32),
    );
  }

  Widget _buildBrand(TextTheme tt, ColorScheme cs) {
    return Row(
      children: [
        Text(
          item.brand,
          style: tt.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.verified, color: Colors.blue, size: 16),
      ],
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
    String variantText = '';
    if (item.color.isNotEmpty && item.size.isNotEmpty) {
      variantText = 'Color: ${item.color} • Size: ${item.size}';
    } else if (item.color.isNotEmpty) {
      variantText = 'Color: ${item.color}';
    } else if (item.size.isNotEmpty) {
      variantText = 'Size: ${item.size}';
    }

    return Text(
      variantText,
      style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
    );
  }

  Widget _buildPriceAndQuantity(
      TextTheme tt, ColorScheme cs, CartController cartController) {
    return Row(
      children: [
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildQuantityButton(Icons.remove, () {
                if (onDecrease != null) {
                  onDecrease!();
                } else {
                  cartController.decrementQuantity(item.id);
                }
              }, cs),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              _buildQuantityButton(Icons.add, () {
                if (onIncrease != null) {
                  onIncrease!();
                } else {
                  cartController.incrementQuantity(item.id);
                }
              }, cs),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildQuantityButton(
      IconData icon, VoidCallback onPressed, ColorScheme cs) {
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
          final cartController = Get.find<CartController>();
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