import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/features/personalization/models/cart_item.dart';
import 'package:ecommerce_store/features/personalization/screens/checkout/checkout.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: TAppBar(
         showBackArrow: true,
        title: Obx(() => Text(
              'My Cart (${cartController.totalQuantity})',
              style: tt.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            )),
      ),
      body: Obx(() => cartController.cartItems.isEmpty
          ? _buildEmptyCart(cs, tt)
          : _buildCartContent(cs, tt)),
      bottomNavigationBar: Obx(() =>
          cartController.cartItems.isNotEmpty
              ? _buildCheckoutSection(cs, tt)
              : const SizedBox.shrink()),
    );
  }

  Widget _buildEmptyCart(ColorScheme cs, TextTheme tt) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 60,
                color: cs.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your cart is empty',
              style: tt.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some items to get started',
              style: tt.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.shopping_bag),
              label: const Text('Start Shopping'),
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent(ColorScheme cs, TextTheme tt) {
    final bottomPadding =
        kBottomNavigationBarHeight + TSizes.defaultSpace * 4;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Obx(() => ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    TSizes.defaultSpace,
                    TSizes.defaultSpace,
                    TSizes.defaultSpace,
                    bottomPadding,
                  ),
                  itemCount: cartController.cartItems.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: TSizes.spaceBtwSections),
                  itemBuilder: (context, index) {
                    final item = cartController.cartItems[index];
                    return _buildCartItem(item, index, cs, tt);
                  },
                )),
          ),
        );
      },
    );
  }

  Widget _buildCartItem(
      CartItem item, int index, ColorScheme cs, TextTheme tt) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  if (Theme.of(context).brightness == Brightness.light)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: cs.surfaceVariant,
                      ),
                     child: ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: item.image.startsWith('assets/') 
      ? Image.asset(  // Use Image.asset for local assets
          item.image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: cs.surfaceVariant,
              child: Icon(Icons.image, color: cs.onSurfaceVariant, size: 32),
            );
          },
        )
      : Image.network(  // Use Image.network for URLs
          item.image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: cs.surfaceVariant,
              child: Icon(Icons.image, color: cs.onSurfaceVariant, size: 32),
            );
          },
        ),
),
                    ),
                    const SizedBox(width: 16),
                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: tt.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: cs.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${item.color} • ${item.size}',
                            style: tt.bodySmall
                                ?.copyWith(color: cs.onSurfaceVariant),
                          ),
                          const SizedBox(height: 8),
                          Row(
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
                              const Spacer(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildQuantityButton(
                                    Icons.remove,
                                    () => cartController
                                        .decrementQuantity(item.id),
                                    cs,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
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
                                    () => cartController
                                        .incrementQuantity(item.id),
                                    cs,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Remove Button
                    IconButton(
                      onPressed: () =>
                          cartController.removeFromCart(item.id),
                      icon: Icon(Icons.close, color: cs.onSurfaceVariant),
                      style: IconButton.styleFrom(
                        backgroundColor: cs.surfaceVariant,
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
        constraints:
            const BoxConstraints(minWidth: 32, minHeight: 32),
      ),
    );
  }

  Widget _buildCheckoutSection(ColorScheme cs, TextTheme tt) {
  return Container(
    decoration: BoxDecoration(
      color: cs.surface,
      boxShadow: [
        if (Theme.of(context).brightness == Brightness.light)
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
      ],
    ),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Order Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(() => Column(
                    children: [
                      _buildSummaryRow('Subtotal', cartController.subtotal, cs, tt),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Shipping', cartController.shipping, cs, tt),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Tax', cartController.tax, cs, tt),
                      const Divider(height: 24),
                      _buildSummaryRow(
                        'Total',
                        cartController.total,
                        cs,
                        tt,
                        isTotal: true,
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 16),
            // Checkout Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: Obx(() => ElevatedButton(
                    onPressed: () {
                      // ✅ Navigate with smooth slide-up transition
                      Get.to(
                        () => const CheckoutScreen(),
                        transition: Transition.downToUp, // slide from bottom
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.primary,
                      foregroundColor: cs.onPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_bag_outlined),
                        const SizedBox(width: 8),
                        Text(
                          'Checkout • \$${cartController.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    ),
  );
}


  Widget _buildSummaryRow(
    String label,
    double amount,
    ColorScheme cs,
    TextTheme tt, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: tt.bodyMedium?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? cs.onSurface : cs.onSurfaceVariant,
          ),
        ),
        Text(
          amount == 0 ? 'FREE' : '\$${amount.toStringAsFixed(2)}',
          style: tt.bodyMedium?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? cs.primary : cs.onSurface,
          ),
        ),
      ],
    );
  }
}
