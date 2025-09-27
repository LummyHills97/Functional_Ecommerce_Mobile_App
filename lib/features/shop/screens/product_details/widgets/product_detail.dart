import 'package:ecommerce_store/common/widgets/curved_edges_widget.dart';
import 'package:ecommerce_store/features/shop/screens/product_reviews/product_review.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? product;

  const ProductDetailScreen({super.key, this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isFavorited = false;
  int selectedImageIndex = 0;
  int quantity = 1;

  String? selectedColor;
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // Product data
    final productName = widget.product?['name'] ?? 'Green Nike Air Shoes';
    final brandName = widget.product?['brand'] ?? 'Nike';
    final price = widget.product?['price'] ?? 25.00;
    final originalPrice = widget.product?['originalPrice'] ?? 35.00;
    final discount = widget.product?['discount'] ?? 25;
    final imageUrl = widget.product?['image'] ?? TImages.productImage1;
    final rating = widget.product?['rating'] ?? 4.5;
    final reviewCount = widget.product?['reviewCount'] ?? 128;

    // Mock extra images
    final productImages = [imageUrl, imageUrl, imageUrl];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Top Section: Image, actions
            TCurvedEdgeWidget(
              child: Container(
                color: dark ? TColors.darkerGrey : TColors.light,
                child: Stack(
                  children: [
                    /// Image slider
                    SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: PageView.builder(
                        itemCount: productImages.length,
                        onPageChanged: (i) => setState(() => selectedImageIndex = i),
                        itemBuilder: (context, i) => Image(
                          image: AssetImage(productImages[i]),
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.shopping_bag_outlined,
                            size: 64,
                            color: dark ? Colors.grey[600] : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),

                    /// Discount
                    if (discount > 0)
                      Positioned(
                        top: 100,
                        left: 20,
                        child: _DiscountBadge(discount: discount),
                      ),

                    /// Indicators
                    if (productImages.length > 1)
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: _ImageIndicators(
                          count: productImages.length,
                          activeIndex: selectedImageIndex,
                        ),
                      ),

                    /// Appbar
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
                        child: _TopActions(
                          isFavorited: isFavorited,
                          onBack: () => Navigator.pop(context),
                          onFavorite: () {
                            setState(() => isFavorited = !isFavorited);
                            _showSnackBar(
                              context,
                              isFavorited
                                  ? 'Added to favorites ❤️'
                                  : 'Removed from favorites',
                            );
                          },
                          onShare: () => _shareProduct(context, productName),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Details
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title + Brand
                  Text(productName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: TSizes.xs),
                  Row(
                    children: [
                      const Icon(Icons.verified, color: TColors.primary, size: 16),
                      const SizedBox(width: TSizes.xs / 2),
                      Text(brandName,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: TColors.primary,
                                fontWeight: FontWeight.w600,
                              )),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Rating
                  _buildRatingSection(context, rating, reviewCount),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Price
                  _PriceSection(price: price, originalPrice: originalPrice),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Variants
                  Text("Options", style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Select Color"),
                    value: selectedColor,
                    items: ["Red", "Blue", "Green"].map((c) =>
                        DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) => setState(() => selectedColor = v),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Select Size"),
                    value: selectedSize,
                    items: ["S", "M", "L", "XL"].map((s) =>
                        DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (v) => setState(() => selectedSize = v),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Quantity
                  _buildQuantitySelector(context),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Description
                  Text("Description",
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Premium quality athletic shoes designed for performance and comfort. '
                    'Features advanced cushioning technology and durable construction '
                    'for all-day wear. Perfect for running, training, and casual activities.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Features
                  _buildFeatures(context),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Add to Cart
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedColor == null || selectedSize == null) {
                          _showSnackBar(context,
                              'Please select color & size first ⚡');
                          return;
                        }
                        _addToCart(
                          context,
                          productName,
                          quantity,
                          selectedColor!,
                          selectedSize!,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: TSizes.md),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(TSizes.cardRadiusSm),
                        ),
                        elevation: 3,
                      ),
                      child: Text(
                        'Add to Cart - \$${(price * quantity).toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Buy Now
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _buyNow(context, productName),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: TColors.primary, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: TSizes.md),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(TSizes.cardRadiusSm),
                        ),
                      ),
                      child: Text(
                        'Buy Now',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: TColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helpers ---
  Widget _buildRatingSection(BuildContext context, double rating, int reviewCount) {
    return Container(
      padding: const EdgeInsets.all(TSizes.md),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(TSizes.md),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  ...List.generate(
                      5,
                      (i) => Icon(
                            i < rating.floor()
                                ? Icons.star
                                : i < rating
                                    ? Icons.star_half
                                    : Icons.star_border,
                            color: Colors.amber,
                            size: 20,
                          )),
                  const SizedBox(width: TSizes.xs),
                  Text(rating.toStringAsFixed(1),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(height: 4),
                Text('$reviewCount reviews',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.color
                              ?.withOpacity(0.7),
                        )),
              ],
            ),
          ),
          Container(width: 1, height: 40, color: Colors.grey.withOpacity(0.3)),
          const SizedBox(width: TSizes.md),
          GestureDetector(
            onTap: () => _showAllReviews(context),
            child: Column(children: [
              const Icon(Icons.rate_review_outlined,
                  color: TColors.primary, size: 24),
              const SizedBox(height: 4),
              Text('Reviews',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: TColors.primary,
                        fontWeight: FontWeight.w600,
                      )),
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Text('Quantity:',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(width: TSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(TSizes.sm),
          ),
          child: Row(children: [
            IconButton(
              onPressed: quantity > 1
                  ? () => setState(() => quantity--)
                  : null,
              icon: Icon(Icons.remove,
                  size: 18,
                  color: quantity > 1
                      ? (dark ? Colors.white : Colors.black)
                      : Colors.grey),
            ),
            SizedBox(
              width: 40,
              child: Text(quantity.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            IconButton(
              onPressed: () => setState(() => quantity++),
              icon: Icon(Icons.add,
                  size: 18, color: dark ? Colors.white : Colors.black),
            ),
          ]),
        ),
        const Spacer(),
        Text('In Stock',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.green, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context) {
    final features = [
      {'icon': Icons.local_shipping, 'title': 'Free Shipping', 'subtitle': 'On orders over \$50'},
      {'icon': Icons.security, 'title': 'Secure Payment', 'subtitle': '100% secure checkout'},
      {'icon': Icons.refresh, 'title': 'Easy Returns', 'subtitle': '30-day return policy'},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Features', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: TSizes.spaceBtwItems),
        ...features.map((f) => ListTile(
              leading: CircleAvatar(
                backgroundColor: TColors.primary.withOpacity(0.1),
                child: Icon(f['icon'] as IconData, color: TColors.primary),
              ),
              title: Text(f['title'] as String,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
              subtitle: Text(f['subtitle'] as String),
            )),
      ],
    );
  }

  // --- Logic ---
  void _addToCart(BuildContext ctx, String productName, int qty, String color, String size) {
    debugPrint("Added: $qty x $productName ($color, $size)");
    _showSnackBar(ctx, 'Added $qty x $productName ($color, $size) to cart! 🛒');
  }

  void _buyNow(BuildContext ctx, String productName) {
    debugPrint("Buy now: $productName");
    _showSnackBar(ctx, 'Proceeding to checkout... 💳');
  }

  void _showSnackBar(BuildContext ctx, String msg) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _shareProduct(BuildContext ctx, String productName) {
    Clipboard.setData(ClipboardData(text: 'Check out this product: $productName'));
    _showSnackBar(ctx, 'Product link copied! 📋');
  }

  void _showAllReviews(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (_) => ProductReviewScreen(
          productName: widget.product?['name'] ?? 'Green Nike Air Shoes',
          rating: widget.product?['rating'] ?? 4.5,
          reviewCount: widget.product?['reviewCount'] ?? 128,
        ),
      ),
    );
  }
}

// --- Small Widgets ---
class _DiscountBadge extends StatelessWidget {
  final int discount;
  const _DiscountBadge({required this.discount});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(8)),
        child: Text('$discount% OFF',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
      );
}

class _ImageIndicators extends StatelessWidget {
  final int count, activeIndex;
  const _ImageIndicators({required this.count, required this.activeIndex});
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          count,
          (i) => Container(
            width: activeIndex == i ? 20 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: activeIndex == i
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
            ),
          ),
        ),
      );
}

class _TopActions extends StatelessWidget {
  final VoidCallback onBack, onShare, onFavorite;
  final bool isFavorited;
  const _TopActions(
      {required this.onBack,
      required this.onShare,
      required this.onFavorite,
      required this.isFavorited});
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleButton(Icons.arrow_back, onBack),
          Row(children: [
            _circleButton(Icons.share, onShare),
            const SizedBox(width: TSizes.xs),
            _circleButton(
                isFavorited ? Icons.favorite : Icons.favorite_border, onFavorite,
                color: Colors.red),
          ])
        ],
      );

  Widget _circleButton(IconData icon, VoidCallback onTap, {Color color = Colors.black}) =>
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
        child: IconButton(
          icon: Icon(icon, color: color, size: 20),
          onPressed: onTap,
        ),
      );
}

class _PriceSection extends StatelessWidget {
  final double price, originalPrice;
  const _PriceSection({required this.price, required this.originalPrice});
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text('\$${price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: TColors.primary, fontWeight: FontWeight.bold)),
          if (originalPrice > price) ...[
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('\$${originalPrice.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: TColors.darkGrey)),
            const SizedBox(width: TSizes.xs),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(4)),
              child: Text(
                'Save \$${(originalPrice - price).toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            )
          ]
        ],
      );
}
