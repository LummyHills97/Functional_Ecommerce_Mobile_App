import 'package:ecommerce_store/common/widgets/products.cart/product_cards/product_card_vertical.dart';
import 'package:ecommerce_store/common/widgets/appbar/home_appbar.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/features/authentication/screens/sub_category/sub_categories.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';

// Mock data models
class Category {
  final String name;
  final IconData icon;
  final Color color;
  Category({required this.name, required this.icon, required this.color});
}

class Banner {
  final String title;
  final String description;
  final String imageUrl;
  Banner({required this.title, required this.description, required this.imageUrl});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CartController cartController = Get.find<CartController>();

  static final List<Category> _categories = [
    Category(name: 'Electronics', icon: Icons.phone_android, color: Colors.blue),
    Category(name: 'Fashion', icon: Icons.checkroom, color: Colors.pink),
    Category(name: 'Shoes', icon: Icons.skateboarding, color: Colors.green),
    Category(name: 'Cosmetics', icon: Icons.face, color: Colors.orange),
    Category(name: 'Sports', icon: Icons.sports_soccer, color: Colors.red),
    Category(name: 'Furniture', icon: Icons.chair, color: Colors.purple),
  ];

  static final List<Banner> _banners = [
    Banner(
      title: 'Summer Sale',
      description: 'Up to 50% off on selected items',
      imageUrl: TImages.banner1,
    ),
    Banner(
      title: 'New Arrivals',
      description: 'Check out our latest collection',
      imageUrl: TImages.banner2,
    ),
    Banner(
      title: 'Free Shipping',
      description: 'On orders above \$50',
      imageUrl: TImages.banner3,
    ),
  ];

  static final List<Map<String, dynamic>> _popularProducts = [
    {
      'id': 'nike_wildhorse_1',
      'name': 'Nike Wildhorse Trail',
      'brand': 'Nike',
      'image': 'assets/images/products/NikeWildhorse.png',
      'price': 129.99,
      'originalPrice': 159.99,
      'discount': 19,
    },
    {
      'id': 'nike_air_max_1',
      'name': 'Nike Air Max',
      'brand': 'Nike', 
      'image': 'assets/images/products/nike-shoes.png',
      'price': 89.99,
      'originalPrice': 119.99,
      'discount': 25,
    },
    {
      'id': 'nike_bennasi_1',
      'name': 'Nike Bennasi',
      'brand': 'Nike',
      'image': 'assets/images/products/product-slippers.png',
      'price': 149.99,
      'originalPrice': 179.99,
      'discount': 17,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildHeader(context),
                Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBannerCarousel(),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      _buildPopularProducts(context),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      _buildFeaturedProducts(context),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      _buildDealsSection(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return TPrimaryHeaderContainer(
      height: 420,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top / 300),
          Obx(() => THomeAppBar(
            userName: 'Olumide Akinnuli',
            cartItemCount: cartController.cartItems.length,
            onCartPressed: () => Get.toNamed('/cart'),
          )),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: TSearchContainer(
              onTap: () => debugPrint('Search tapped'),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: _buildPopularCategories(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Categories',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: TColors.textWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final category = _categories[index];
              return _CategoryItem(
                category: category,
                onTap: () => Get.to(() => const SubCategoriesScreen()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBannerCarousel() {
    return _BannerCarousel(
      banners: _banners,
      height: 190,
      onBannerTap: (banner) => debugPrint('Tapped on banner: ${banner.title}'),
    );
  }

  Widget _buildPopularProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Popular Products', () {
          debugPrint('View all popular products');
        }),
        const SizedBox(height: TSizes.spaceBtwItems),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _popularProducts.length,
            separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final product = _popularProducts[index];

              return SizedBox(
                width: 180,
                child: TProductCardVertical(
                  product: product,
                  onAddToCart: () {
                    _showAddToCartDialog(context, product, cartController);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Featured Categories', () {
          debugPrint('View all featured');
        }),
        const SizedBox(height: TSizes.spaceBtwItems),
        Row(
          children: [
            _buildFeaturedCategory(
              context,
              'Electronics',
              Icons.laptop_mac,
              isDarkMode ? Colors.orange[800]! : Colors.orange[100]!,
              isDarkMode ? Colors.orange[400]! : Colors.orange[700]!,
              isDarkMode ? Colors.orange[600]! : Colors.transparent,
              isDarkMode,
              () => Get.to(() => const SubCategoriesScreen()),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            _buildFeaturedCategory(
              context,
              'Fashion',
              Icons.checkroom,
              isDarkMode ? Colors.pink[800]! : Colors.pink[100]!,
              isDarkMode ? Colors.pink[400]! : Colors.pink[700]!,
              isDarkMode ? Colors.pink[600]! : Colors.transparent,
              isDarkMode,
              () => Get.to(() => const SubCategoriesScreen()),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            _buildFeaturedCategory(
              context,
              'Sports',
              Icons.sports_soccer,
              isDarkMode ? Colors.green[800]! : Colors.green[100]!,
              isDarkMode ? Colors.green[400]! : Colors.green[700]!,
              isDarkMode ? Colors.green[600]! : Colors.transparent,
              isDarkMode,
              () => Get.to(() => const SubCategoriesScreen()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturedCategory(
    BuildContext context,
    String title,
    IconData icon,
    Color bgColor,
    Color iconColor,
    Color borderColor,
    bool isDarkMode,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(TSizes.md),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDarkMode ? Colors.white : TColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDealsSection(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Deal",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : TColors.primary,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Container(
          height: 125,
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [Colors.grey[800]!, Colors.grey[700]!]
                  : [Colors.blue[50]!, Colors.blue[100]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(TSizes.md),
            border: isDarkMode
                ? Border.all(color: Colors.grey[600]!, width: 1)
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Flash Sale',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : TColors.primary,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Limited time offers',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDarkMode
                              ? Colors.grey[300]
                              : Colors.grey[600],
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: TColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Shop Now',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 64,
                  height: 64,
                  child: Center(
                    child: Icon(
                      Icons.local_fire_department,
                      size: 44,
                      color: Colors.red[400],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        TextButton(
          onPressed: onViewAll,
          child: Text(
            'View All', 
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }

  void _showAddToCartDialog(
    BuildContext context, 
    Map<String, dynamic> product,
    CartController cartController,
  ) {
    String? selectedSize;
    String? selectedColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final sizes = ['S', 'M', 'L', 'XL'];
    final colors = ['Black', 'White', 'Blue', 'Red', 'Green'];
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: isDark ? TColors.dark : Colors.white,
          title: Text(
            product['name'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : TColors.dark,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      product['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                Text(
                  "\$${product['price']}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: TColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                
                Text(
                  'Select Size:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : TColors.dark,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: sizes.map((size) {
                    final isSelected = selectedSize == size;
                    return ChoiceChip(
                      label: Text(size),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedSize = selected ? size : null;
                        });
                      },
                      selectedColor: TColors.primary,
                      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black),
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                
                Text(
                  'Select Color:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : TColors.dark,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: colors.map((color) {
                    final isSelected = selectedColor == color;
                    return ChoiceChip(
                      label: Text(color),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedColor = selected ? color : null;
                        });
                      },
                      selectedColor: TColors.primary,
                      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black),
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: isDark ? Colors.white70 : TColors.dark),
              ),
            ),
            ElevatedButton(
              onPressed: (selectedSize != null && selectedColor != null)
                  ? () {
                      cartController.quickAddToCart(
                        productId: product['id'],
                        productName: product['name'],
                        productPrice: product['price'].toDouble(),
                        productImage: product['image'],
                        productBrand: product['brand'],
                        productSize: selectedSize,
                        productColor: selectedColor,
                      );
                      
                      Navigator.pop(context);
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${product['name']} ($selectedColor, $selectedSize) added to cart'
                          ),
                          duration: const Duration(seconds: 2),
                          backgroundColor: TColors.primary,
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  const _CategoryItem({required this.category, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: category.color.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Icon(
              category.icon,
              color: category.color,
              size: 28,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            category.name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: TColors.textWhite,
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _BannerCarousel extends StatefulWidget {
  final List<Banner> banners;
  final double height;
  final Function(Banner) onBannerTap;
  const _BannerCarousel({
    required this.banners,
    required this.height,
    required this.onBannerTap,
  });
  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentIndex < widget.banners.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.banners.length,
            itemBuilder: (context, index) {
              final banner = widget.banners[index];
              return GestureDetector(
                onTap: () => widget.onBannerTap(banner),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(TSizes.md),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(TSizes.md),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          banner.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.image_not_supported, size: 50),
                              ),
                            );
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                banner.title,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                banner.description,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.banners.length,
            (index) => Container(
              width: _currentIndex == index ? 20 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}