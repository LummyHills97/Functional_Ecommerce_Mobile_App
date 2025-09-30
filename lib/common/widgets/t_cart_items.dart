import 'package:ecommerce_store/features/personalization/models/cart_item.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    required this.item,
    this.showQuantityControls = true,
    this.showRemoveButton = true,
    this.padding = const EdgeInsets.all(TSizes.defaultSpace),
  });

  final CartItem item;
  final bool showQuantityControls;
  final bool showRemoveButton;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outline.withOpacity(0.2)),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: cs.surfaceVariant,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.image.startsWith('assets/')
                    ? Image.asset(
                        item.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image,
                            color: cs.onSurfaceVariant,
                            size: 32,
                          );
                        },
                      )
                    : Image.network(
                        item.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image,
                            color: cs.onSurfaceVariant,
                            size: 32,
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: tt.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // ✅ FIXED: Show brand, color, and size
                  Text(
                    _buildProductDetails(item),
                    style: tt.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Price and Quantity
                  Row(
                    children: [
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: tt.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: cs.primary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Qty: ${item.quantity}',
                        style: tt.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ NEW: Helper method to build product details string
  String _buildProductDetails(CartItem item) {
    final details = <String>[];
    
    if (item.brand != null && item.brand!.isNotEmpty) {
      details.add(item.brand!);
    }
    if (item.color != null && item.color!.isNotEmpty) {
      details.add(item.color!);
    }
    if (item.size != null && item.size!.isNotEmpty) {
      details.add(item.size!);
    }
    
    return details.isEmpty ? 'No details available' : details.join(' • ');
  }
}