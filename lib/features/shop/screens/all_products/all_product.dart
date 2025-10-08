import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/products.cart/product_cards/product_card_vertical.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final CartController cartController = Get.find<CartController>();
  String selectedCategory = 'All';

  // Complete product list with various categories
  final List<Map<String, dynamic>> allProducts = [
    // Nike Shoes
    {
      'id': 'nike_air_jordan_black_red',
      'name': 'Nike Air Jordan Black Red',
      'brand': 'Nike',
      'category': 'Shoes',
      'image': TImages.productImage7,
      'price': 189.99,
      'originalPrice': 249.99,
      'discount': 24,
    },
    {
      'id': 'nike_air_jordan_orange',
      'name': 'Nike Air Jordan Orange',
      'brand': 'Nike',
      'category': 'Shoes',
      'image': TImages.productImage8,
      'price': 179.99,
      'originalPrice': 239.99,
      'discount': 25,
    },
    {
      'id': 'nike_air_jordan_white_magenta',
      'name': 'Nike Air Jordan White Magenta',
      'brand': 'Nike',
      'category': 'Shoes',
      'image': TImages.productImage9,
      'price': 199.99,
      'originalPrice': 259.99,
      'discount': 23,
    },
    {
      'id': 'nike_wildhorse',
      'name': 'Nike Wildhorse Trail',
      'brand': 'Nike',
      'category': 'Shoes',
      'image': TImages.productImage23,
      'price': 129.99,
      'originalPrice': 169.99,
      'discount': 24,
    },
    {
      'id': 'nike_air_max',
      'name': 'Nike Air Max',
      'brand': 'Nike',
      'category': 'Shoes',
      'image': TImages.productImage21,
      'price': 149.99,
      'originalPrice': 199.99,
      'discount': 25,
    },
    {
      'id': 'nike_basketball_shoe',
      'name': 'Nike Basketball Shoe',
      'brand': 'Nike',
      'category': 'Shoes',
      'image': TImages.productImage22,
      'price': 139.99,
      'originalPrice': 179.99,
      'discount': 22,
    },
    
    // Electronics - Smartphones
    {
      'id': 'iphone_14_pro',
      'name': 'iPhone 14 Pro',
      'brand': 'Apple',
      'category': 'Electronics',
      'image': TImages.productImage52,
      'price': 999.99,
      'originalPrice': 1199.99,
      'discount': 17,
    },
    {
      'id': 'iphone_13_pro',
      'name': 'iPhone 13 Pro',
      'brand': 'Apple',
      'category': 'Electronics',
      'image': TImages.productImage51,
      'price': 899.99,
      'originalPrice': 1099.99,
      'discount': 18,
    },
    {
      'id': 'iphone_12_red',
      'name': 'iPhone 12 Red',
      'brand': 'Apple',
      'category': 'Electronics',
      'image': TImages.productImage70,
      'price': 699.99,
      'originalPrice': 899.99,
      'discount': 22,
    },
    {
      'id': 'samsung_s9',
      'name': 'Samsung Galaxy S9',
      'brand': 'Samsung',
      'category': 'Electronics',
      'image': TImages.productImage11,
      'price': 499.99,
      'originalPrice': 699.99,
      'discount': 29,
    },
    
    // Electronics - Laptops
    {
      'id': 'acer_laptop_1',
      'name': 'Acer Aspire 5',
      'brand': 'Acer',
      'category': 'Electronics',
      'image': TImages.productImage47,
      'price': 649.99,
      'originalPrice': 799.99,
      'discount': 19,
    },
    {
      'id': 'acer_laptop_2',
      'name': 'Acer Predator Gaming',
      'brand': 'Acer',
      'category': 'Electronics',
      'image': TImages.productImage48,
      'price': 1299.99,
      'originalPrice': 1599.99,
      'discount': 19,
    },
    
    // Fashion - Clothing
    {
      'id': 'leather_jacket_black',
      'name': 'Black Leather Jacket',
      'brand': 'Zara',
      'category': 'Fashion',
      'image': TImages.productImage64,
      'price': 129.99,
      'originalPrice': 179.99,
      'discount': 28,
    },
    {
      'id': 'leather_jacket_brown',
      'name': 'Brown Leather Jacket',
      'brand': 'Zara',
      'category': 'Fashion',
      'image': TImages.productImage65,
      'price': 139.99,
      'originalPrice': 189.99,
      'discount': 26,
    },
    {
      'id': 'tshirt_red_collar',
      'name': 'Red Collar T-Shirt',
      'brand': 'Nike',
      'category': 'Fashion',
      'image': TImages.productImage60,
      'price': 29.99,
      'originalPrice': 49.99,
      'discount': 40,
    },
    {
      'id': 'tshirt_blue_collar',
      'name': 'Blue Collar T-Shirt',
      'brand': 'Nike',
      'category': 'Fashion',
      'image': TImages.productImage63,
      'price': 29.99,
      'originalPrice': 49.99,
      'discount': 40,
    },
    {
      'id': 'tracksuit_black',
      'name': 'Black Tracksuit',
      'brand': 'Adidas',
      'category': 'Fashion',
      'image': TImages.productImage24,
      'price': 89.99,
      'originalPrice': 129.99,
      'discount': 31,
    },
    {
      'id': 'tracksuit_blue',
      'name': 'Blue Tracksuit',
      'brand': 'Adidas',
      'category': 'Fashion',
      'image': TImages.productImage25,
      'price': 89.99,
      'originalPrice': 129.99,
      'discount': 31,
    },
    
    // Furniture
    {
      'id': 'bedroom_bed',
      'name': 'Modern Bedroom Bed',
      'brand': 'IKEA',
      'category': 'Furniture',
      'image': TImages.productImage32,
      'price': 399.99,
      'originalPrice': 549.99,
      'discount': 27,
    },
    {
      'id': 'office_chair_1',
      'name': 'Ergonomic Office Chair',
      'brand': 'Herman Miller',
      'category': 'Furniture',
      'image': TImages.productImage39,
      'price': 299.99,
      'originalPrice': 449.99,
      'discount': 33,
    },
    {
      'id': 'office_desk_1',
      'name': 'Modern Office Desk',
      'brand': 'IKEA',
      'category': 'Furniture',
      'image': TImages.productImage41,
      'price': 249.99,
      'originalPrice': 349.99,
      'discount': 29,
    },
    {
      'id': 'bedroom_wardrobe',
      'name': 'Spacious Wardrobe',
      'brand': 'IKEA',
      'category': 'Furniture',
      'image': TImages.productImage35,
      'price': 499.99,
      'originalPrice': 699.99,
      'discount': 29,
    },
    
    // Sports
    {
      'id': 'adidas_football',
      'name': 'Adidas Football',
      'brand': 'Adidas',
      'category': 'Sports',
      'image': TImages.productImage28,
      'price': 29.99,
      'originalPrice': 49.99,
      'discount': 40,
    },
    {
      'id': 'cricket_bat',
      'name': 'Professional Cricket Bat',
      'brand': 'Puma',
      'category': 'Sports',
      'image': TImages.productImage30,
      'price': 79.99,
      'originalPrice': 119.99,
      'discount': 33,
    },
    {
      'id': 'tennis_racket',
      'name': 'Tennis Racket Pro',
      'brand': 'Nike',
      'category': 'Sports',
      'image': TImages.productImage31,
      'price': 99.99,
      'originalPrice': 149.99,
      'discount': 33,
    },
  ];

  List<String> get categories {
    final cats = allProducts.map((p) => p['category'] as String).toSet().toList();
    cats.insert(0, 'All');
    return cats;
  }

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == 'All') {
      return allProducts;
    }
    return allProducts.where((p) => p['category'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: TAppBar(
        title: const Text('All Products'),
        showBackArrow: true,
      ),
      body: Column(
        children: [
          // Category Filter Chips
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  selectedColor: TColors.primary,
                  backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                );
              },
            ),
          ),
          
          // Products Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: Row(
              children: [
                Text(
                  '${filteredProducts.length} Products',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: TSizes.spaceBtwItems),
          
          // Products Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: TSizes.gridViewSpacing,
                crossAxisSpacing: TSizes.gridViewSpacing,
                mainAxisExtent: 300,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return TProductCardVertical(
                  product: product,
                  onAddToCart: () {
                    _showAddToCartDialog(context, product, cartController);
                  },
                );
              },
            ),
          ),
        ],
      ),
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
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image, size: 50);
                      },
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
                        color: isSelected
                            ? Colors.white
                            : (isDark ? Colors.white : Colors.black),
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
                        color: isSelected
                            ? Colors.white
                            : (isDark ? Colors.white : Colors.black),
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
                            '${product['name']} ($selectedColor, $selectedSize) added to cart',
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