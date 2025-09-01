import 'package:ecommerce_store/common/widgets/curved_edges_widget.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? product;
  
  const ProductDetailScreen({
    super.key,
    this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isFavorited = false;
  int selectedImageIndex = 0;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    
    // Use product data if available, otherwise use defaults
    final productName = widget.product?['name'] ?? 'Green Nike Air Shoes';
    final brandName = widget.product?['brand'] ?? 'Nike';
    final price = widget.product?['price'] ?? 25.00;
    final originalPrice = widget.product?['originalPrice'] ?? 35.00;
    final discount = widget.product?['discount'] ?? 25;
    final imageUrl = widget.product?['image'] ?? TImages.productImage1;
    final rating = widget.product?['rating'] ?? 4.5;
    final reviewCount = widget.product?['reviewCount'] ?? 128;

    // Mock additional images for the product
    final productImages = [
      imageUrl,
      imageUrl,
      imageUrl,
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Slider with App Bar
            TCurvedEdgeWidget(
              child: Container(
                color: dark ? TColors.darkerGrey : TColors.light,
                child: Stack(
                  children: [
                    // Main large image
                    Container(
                      height: 400,
                      width: double.infinity,
                      child: PageView.builder(
                        itemCount: productImages.length,
                        onPageChanged: (index) {
                          setState(() {
                            selectedImageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Image(
                            image: AssetImage(productImages[index]),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: dark ? Colors.grey[800] : Colors.grey[200],
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 64,
                                  color: dark ? Colors.grey[600] : Colors.grey[400],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    // Discount badge
                    if (discount > 0)
                      Positioned(
                        top: 100,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$discount% OFF',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                    // Image indicators
                    if (productImages.length > 1)
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            productImages.length,
                            (index) => Container(
                              width: selectedImageIndex == index ? 20 : 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: selectedImageIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),

                    // App Bar
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back Button
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),

                            // Action Buttons
                            Row(
                              children: [
                                // Share Button
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                    onPressed: () => _shareProduct(context, productName),
                                  ),
                                ),
                                const SizedBox(width: TSizes.xs),
                                
                                // Favorite Button
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      isFavorited ? Icons.favorite : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isFavorited = !isFavorited;
                                      });
                                      _showSnackBar(
                                        context,
                                        isFavorited 
                                            ? 'Added to favorites ❤️'
                                            : 'Removed from favorites',
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Product Details
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name and brand
                  Text(
                    productName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: TSizes.xs),
                  Row(
                    children: [
                      const Icon(Icons.verified, color: TColors.primary, size: 16),
                      const SizedBox(width: TSizes.xs / 2),
                      Text(
                        brandName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: TColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: TSizes.spaceBtwItems),
                  
                  // Rating Section
                  _buildRatingSection(context, rating, reviewCount),
                  
                  const SizedBox(height: TSizes.spaceBtwItems),
                  
                  // Price section
                  Row(
                    children: [
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: TColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      if (originalPrice > price)
                        Text(
                          '\$${originalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: TColors.darkGrey,
                          ),
                        ),
                      if (originalPrice > price)
                        const SizedBox(width: TSizes.xs),
                      if (originalPrice > price)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Save \$${(originalPrice - price).toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: TSizes.spaceBtwSections),
                  
                  // Quantity Selector
                  _buildQuantitySelector(context),
                  
                  const SizedBox(height: TSizes.spaceBtwSections),
                  
                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Premium quality athletic shoes designed for performance and comfort. Features advanced cushioning technology and durable construction for all-day wear. Perfect for running, training, and casual activities.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: TSizes.spaceBtwSections),
                  
                  // Features
                  _buildFeatures(context),
                  
                  const SizedBox(height: TSizes.spaceBtwSections),
                  
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _addToCart(context, productName, quantity),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: TSizes.md),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
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
                  
                  // Buy Now Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _buyNow(context, productName),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: TColors.primary, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: TSizes.md),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
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

  // Rating Section Widget
  Widget _buildRatingSection(BuildContext context, double rating, int reviewCount) {
    return Container(
      padding: const EdgeInsets.all(TSizes.md),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(TSizes.md),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < rating.floor()
                            ? Icons.star
                            : index < rating
                                ? Icons.star_half
                                : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
                    }),
                    const SizedBox(width: TSizes.xs),
                    Text(
                      rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$reviewCount reviews',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Theme.of(context).dividerColor.withOpacity(0.3),
          ),
          const SizedBox(width: TSizes.md),
          GestureDetector(
            onTap: () => _showAllReviews(context),
            child: Column(
              children: [
                Icon(
                  Icons.rate_review_outlined,
                  color: TColors.primary,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  'Reviews',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: TColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Quantity Selector Widget
  Widget _buildQuantitySelector(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    
    return Row(
      children: [
        Text(
          'Quantity:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(TSizes.sm),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: quantity > 1
                    ? () {
                        setState(() {
                          quantity--;
                        });
                      }
                    : null,
                icon: Icon(
                  Icons.remove,
                  size: 18,
                  color: quantity > 1
                      ? (dark ? Colors.white : Colors.black)
                      : Colors.grey,
                ),
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  quantity.toString(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
                icon: Icon(
                  Icons.add,
                  size: 18,
                  color: dark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          'In Stock',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Features Section
  Widget _buildFeatures(BuildContext context) {
    final features = [
      {'icon': Icons.local_shipping, 'title': 'Free Shipping', 'subtitle': 'On orders over \$50'},
      {'icon': Icons.security, 'title': 'Secure Payment', 'subtitle': '100% secure checkout'},
      {'icon': Icons.refresh, 'title': 'Easy Returns', 'subtitle': '30-day return policy'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Features',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        ...features.map((feature) => Padding(
          padding: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: TColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature['title'] as String,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      feature['subtitle'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  // Share Product Function
  void _shareProduct(BuildContext context, String productName) {
    // In a real app, you would use the share_plus package
    // For now, we'll copy to clipboard and show a snackbar
    Clipboard.setData(ClipboardData(text: 'Check out this amazing product: $productName'));
    _showSnackBar(context, 'Product link copied to clipboard! 📋');
    
    // You can also show a share bottom sheet
    _showShareBottomSheet(context, productName);
  }

  // Share Bottom Sheet
  void _showShareBottomSheet(BuildContext context, String productName) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(TSizes.lg)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'Share Product',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ShareOption(
                  icon: Icons.message,
                  label: 'Messages',
                  onTap: () {
                    Navigator.pop(context);
                    _showSnackBar(context, 'Opening Messages...');
                  },
                ),
                _ShareOption(
                  icon: Icons.email,
                  label: 'Email',
                  onTap: () {
                    Navigator.pop(context);
                    _showSnackBar(context, 'Opening Email...');
                  },
                ),
                _ShareOption(
                  icon: Icons.link,
                  label: 'Copy Link',
                  onTap: () {
                    Navigator.pop(context);
                    Clipboard.setData(ClipboardData(text: 'https://store.com/product/$productName'));
                    _showSnackBar(context, 'Link copied! 🔗');
                  },
                ),
                _ShareOption(
                  icon: Icons.more_horiz,
                  label: 'More',
                  onTap: () {
                    Navigator.pop(context);
                    _showSnackBar(context, 'More options...');
                  },
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }

  // Show All Reviews
  void _showAllReviews(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(TSizes.lg)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Customer Reviews',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: 5, // Mock reviews
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) => _ReviewItem(
                    rating: [5, 4, 5, 3, 4][index],
                    userName: ['John D.', 'Sarah M.', 'Mike R.', 'Lisa K.', 'Tom W.'][index],
                    comment: [
                      'Excellent quality! Very comfortable and stylish.',
                      'Good shoes but sizing runs a bit small.',
                      'Love these! Perfect for my morning runs.',
                      'Decent quality for the price.',
                      'Great customer service and fast delivery.'
                    ][index],
                    date: '${index + 1} days ago',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Functions
  void _addToCart(BuildContext context, String productName, int quantity) {
    debugPrint('Added to cart: $productName x$quantity');
    _showSnackBar(context, 'Added $quantity x $productName to cart! 🛒');
  }

  void _buyNow(BuildContext context, String productName) {
    debugPrint('Buy now: $productName');
    _showSnackBar(context, 'Proceeding to checkout... 💳');
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.sm),
        ),
      ),
    );
  }
}

// Share Option Widget
class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ShareOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: TColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: TColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

// Review Item Widget
class _ReviewItem extends StatelessWidget {
  final int rating;
  final String userName;
  final String comment;
  final String date;

  const _ReviewItem({
    required this.rating,
    required this.userName,
    required this.comment,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: TColors.primary.withOpacity(0.1),
                child: Text(
                  userName[0],
                  style: TextStyle(
                    color: TColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: TSizes.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 14,
                          );
                        }),
                        const SizedBox(width: TSizes.xs),
                        Text(
                          date,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.xs),
          Text(
            comment,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}