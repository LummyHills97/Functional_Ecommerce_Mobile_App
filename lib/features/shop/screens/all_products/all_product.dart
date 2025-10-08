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
  String selectedSortOption = 'Newest';

  // Complete product list with all available images
  final List<Map<String, dynamic>> allProducts = [
    // Nike Shoes
    {
      'id': 'nike_shoes_1',
      'name': 'Nike Classic Shoes',
      'brand': 'Nike',
      'category': 'Shoes',
      'image': TImages.productImage1,
      'price': 159.99,
      'originalPrice': 219.99,
      'discount': 27,
    },
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
      'id': 'nike_air_jordan_white_red',
      'name': 'Nike Air Jordan White Red',
      'brand': 'Nike',
      'category': 'Shoes',
      'image': TImages.productImage10,
      'price': 194.99,
      'originalPrice': 254.99,
      'discount': 24,
    },
    {
      'id': 'nike_air_jordan_single_blue',
      'name': 'Nike Air Jordan Blue',
      'brand': 'Nike',
      'category': 'Shoes',
      'image': TImages.productImage19,
      'price': 184.99,
      'originalPrice': 244.99,
      'discount': 25,
    },
    {
      'id': 'nike_air_jordan_single_orange',
      'name': 'Nike Air Jordan Single Orange',
      'brand': 'Nike',
      'category': 'Shoes',
      'image': TImages.productImage20,
      'price': 174.99,
      'originalPrice': 234.99,
      'discount': 26,
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
    {
      'id': 'product_slippers',
      'name': 'Comfort Slippers',
      'brand': 'Nike',
      'category': 'Shoes',
      'image': TImages.productImage6,
      'price': 39.99,
      'originalPrice': 59.99,
      'discount': 33,
    },
    {
      'id': 'slipper_1',
      'name': 'Premium Slide Slippers',
      'brand': 'Adidas',
      'category': 'Shoes',
      'image': TImages.productImage74,
      'price': 44.99,
      'originalPrice': 64.99,
      'discount': 31,
    },
    {
      'id': 'slipper_2',
      'name': 'Sport Slide Slippers',
      'brand': 'Puma',
      'category': 'Shoes',
      'image': TImages.productImage75,
      'price': 42.99,
      'originalPrice': 62.99,
      'discount': 32,
    },
    {
      'id': 'slipper_3',
      'name': 'Casual Slippers',
      'brand': 'Nike',
      'category': 'Shoes',
      'image': TImages.productImage76,
      'price': 37.99,
      'originalPrice': 57.99,
      'discount': 34,
    },
    {
      'id': 'slipper_4',
      'name': 'Classic Slippers',
      'brand': 'Adidas',
      'category': 'Shoes',
      'image': TImages.productImage77,
      'price': 39.99,
      'originalPrice': 59.99,
      'discount': 33,
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
      'id': 'iphone_14_white',
      'name': 'iPhone 14 White',
      'brand': 'Apple',
      'category': 'Electronics',
      'image': TImages.productImage53,
      'price': 899.99,
      'originalPrice': 1099.99,
      'discount': 18,
    },
    {
      'id': 'iphone_13_pro',
      'name': 'iPhone 13 Pro',
      'brand': 'Apple',
      'category': 'Electronics',
      'image': TImages.productImage51,
      'price': 849.99,
      'originalPrice': 1049.99,
      'discount': 19,
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
      'id': 'iphone_12_blue',
      'name': 'iPhone 12 Blue',
      'brand': 'Apple',
      'category': 'Electronics',
      'image': TImages.productImage71,
      'price': 699.99,
      'originalPrice': 899.99,
      'discount': 22,
    },
    {
      'id': 'iphone_12_green',
      'name': 'iPhone 12 Green',
      'brand': 'Apple',
      'category': 'Electronics',
      'image': TImages.productImage72,
      'price': 699.99,
      'originalPrice': 899.99,
      'discount': 22,
    },
    {
      'id': 'iphone_12_black',
      'name': 'iPhone 12 Black',
      'brand': 'Apple',
      'category': 'Electronics',
      'image': TImages.productImage73,
      'price': 699.99,
      'originalPrice': 899.99,
      'discount': 22,
    },
    {
      'id': 'iphone_8_mobile',
      'name': 'iPhone 8',
      'brand': 'Apple',
      'category': 'Electronics',
      'image': TImages.productImage14,
      'price': 399.99,
      'originalPrice': 549.99,
      'discount': 27,
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
    {
      'id': 'acer_laptop_3',
      'name': 'Acer Swift 3',
      'brand': 'Acer',
      'category': 'Electronics',
      'image': TImages.productImage49,
      'price': 699.99,
      'originalPrice': 899.99,
      'discount': 22,
    },
    {
      'id': 'acer_laptop_4',
      'name': 'Acer Nitro 5',
      'brand': 'Acer',
      'category': 'Electronics',
      'image': TImages.productImage50,
      'price': 899.99,
      'originalPrice': 1149.99,
      'discount': 22,
    },
    
    // Fashion - Clothing
    {
      'id': 'product_jacket',
      'name': 'Classic Jacket',
      'brand': 'Zara',
      'category': 'Fashion',
      'image': TImages.productImage3,
      'price': 119.99,
      'originalPrice': 169.99,
      'discount': 29,
    },
    {
      'id': 'product_jeans',
      'name': 'Denim Jeans',
      'brand': 'Zara',
      'category': 'Fashion',
      'image': TImages.productImage4,
      'price': 79.99,
      'originalPrice': 119.99,
      'discount': 33,
    },
    {
      'id': 'product_shirt',
      'name': 'Casual Shirt',
      'brand': 'Zara',
      'category': 'Fashion',
      'image': TImages.productImage5,
      'price': 49.99,
      'originalPrice': 79.99,
      'discount': 38,
    },
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
      'id': 'leather_jacket_3',
      'name': 'Premium Leather Jacket',
      'brand': 'Zara',
      'category': 'Fashion',
      'image': TImages.productImage66,
      'price': 149.99,
      'originalPrice': 199.99,
      'discount': 25,
    },
    {
      'id': 'leather_jacket_4',
      'name': 'Vintage Leather Jacket',
      'brand': 'Zara',
      'category': 'Fashion',
      'image': TImages.productImage67,
      'price': 159.99,
      'originalPrice': 219.99,
      'discount': 27,
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
      'id': 'tshirt_yellow_collar',
      'name': 'Yellow Collar T-Shirt',
      'brand': 'Nike',
      'category': 'Fashion',
      'image': TImages.productImage61,
      'price': 29.99,
      'originalPrice': 49.99,
      'discount': 40,
    },
    {
      'id': 'tshirt_green_collar',
      'name': 'Green Collar T-Shirt',
      'brand': 'Nike',
      'category': 'Fashion',
      'image': TImages.productImage62,
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
      'id': 'shirt_blue_1',
      'name': 'Blue Shirt Classic',
      'brand': 'Zara',
      'category': 'Fashion',
      'image': TImages.productImage54,
      'price': 54.99,
      'originalPrice': 84.99,
      'discount': 35,
    },
    {
      'id': 'shirt_blue_2',
      'name': 'Blue Shirt Premium',
      'brand': 'Zara',
      'category': 'Fashion',
      'image': TImages.productImage55,
      'price': 59.99,
      'originalPrice': 89.99,
      'discount': 33,
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
    {
      'id': 'tracksuit_red',
      'name': 'Red Tracksuit',
      'brand': 'Adidas',
      'category': 'Fashion',
      'image': TImages.productImage26,
      'price': 89.99,
      'originalPrice': 129.99,
      'discount': 31,
    },
    {
      'id': 'tracksuit_parrot_green',
      'name': 'Parrot Green Tracksuit',
      'brand': 'Adidas',
      'category': 'Fashion',
      'image': TImages.productImage27,
      'price': 89.99,
      'originalPrice': 129.99,
      'discount': 31,
    },
    
    // Furniture - Bedroom
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
      'id': 'bedroom_bed_black',
      'name': 'Black Bedroom Bed',
      'brand': 'IKEA',
      'category': 'Furniture',
      'image': TImages.productImage43,
      'price': 429.99,
      'originalPrice': 579.99,
      'discount': 26,
    },
    {
      'id': 'bedroom_bed_grey',
      'name': 'Grey Bedroom Bed',
      'brand': 'IKEA',
      'category': 'Furniture',
      'image': TImages.productImage44,
      'price': 419.99,
      'originalPrice': 569.99,
      'discount': 26,
    },
    {
      'id': 'bedroom_bed_brown',
      'name': 'Simple Brown Bed',
      'brand': 'IKEA',
      'category': 'Furniture',
      'image': TImages.productImage45,
      'price': 389.99,
      'originalPrice': 529.99,
      'discount': 26,
    },
    {
      'id': 'bedroom_bed_comforter',
      'name': 'Bed with Comforter',
      'brand': 'IKEA',
      'category': 'Furniture',
      'image': TImages.productImage46,
      'price': 449.99,
      'originalPrice': 599.99,
      'discount': 25,
    },
    {
      'id': 'bedroom_lamp',
      'name': 'Bedroom Lamp',
      'brand': 'IKEA',
      'category': 'Furniture',
      'image': TImages.productImage33,
      'price': 49.99,
      'originalPrice': 79.99,
      'discount': 38,
    },
    {
      'id': 'bedroom_sofa',
      'name': 'Bedroom Sofa',
      'brand': 'IKEA',
      'category': 'Furniture',
      'image': TImages.productImage34,
      'price': 299.99,
      'originalPrice': 429.99,
      'discount': 30,
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
    
    // Furniture - Kitchen
    {
      'id': 'kitchen_counter',
      'name': 'Kitchen Counter',
      'brand': 'IKEA',
      'category': 'Furniture',
      'image': TImages.productImage36,
      'price': 349.99,
      'originalPrice': 499.99,
      'discount': 30,
    },
    {
      'id': 'kitchen_dining_table',
      'name': 'Dining Table',
      'brand': 'IKEA',
      'category': 'Furniture',
      'image': TImages.productImage37,
      'price': 399.99,
      'originalPrice': 549.99,
      'discount': 27,
    },
    {
      'id': 'kitchen_refrigerator',
      'name': 'Modern Refrigerator',
      'brand': 'Kenwood',
      'category': 'Furniture',
      'image': TImages.productImage38,
      'price': 799.99,
      'originalPrice': 1099.99,
      'discount': 27,
    },
    
    // Furniture - Office
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
      'id': 'office_chair_2',
      'name': 'Executive Office Chair',
      'brand': 'Herman Miller',
      'category': 'Furniture',
      'image': TImages.productImage40,
      'price': 349.99,
      'originalPrice': 499.99,
      'discount': 30,
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
      'id': 'office_desk_2',
      'name': 'Executive Office Desk',
      'brand': 'IKEA',
      'category': 'Furniture',
      'image': TImages.productImage42,
      'price': 299.99,
      'originalPrice': 419.99,
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
      'id': 'baseball_bat',
      'name': 'Professional Baseball Bat',
      'brand': 'Puma',
      'category': 'Sports',
      'image': TImages.productImage29,
      'price': 69.99,
      'originalPrice': 109.99,
      'discount': 36,
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
    
    // Animals
    {
      'id': 'tomi_dogfood',
      'name': 'Tomi Dog Food Premium',
      'brand': 'Tomi',
      'category': 'Animals',
      'image': TImages.productImage18,
      'price': 24.99,
      'originalPrice': 39.99,
      'discount': 38,
    },
  ];

  List<String> get categories {
    final cats = allProducts.map((p) => p['category'] as String).toSet().toList();
    cats.insert(0, 'All');
    return cats;
  }

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> products;
    
    if (selectedCategory == 'All') {
      products = List.from(allProducts);
    } else {
      products = allProducts.where((p) => p['category'] == selectedCategory).toList();
    }
    
    // Apply sorting
    switch (selectedSortOption) {
      case 'Name':
        products.sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));
        break;
      case 'Price: Low to High':
        products.sort((a, b) => (a['price'] as double).compareTo(b['price'] as double));
        break;
      case 'Price: High to Low':
        products.sort((a, b) => (b['price'] as double).compareTo(a['price'] as double));
        break;
      case 'Discount':
        products.sort((a, b) => (b['discount'] as int).compareTo(a['discount'] as int));
        break;
      case 'Newest':
        // Keep original order for newest
        break;
      case 'Popularity':
        products.sort((a, b) => (b['discount'] as int).compareTo(a['discount'] as int));
        break;
    }
    
    return products;
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
          
          // Products Count and Sort Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredProducts.length} Products',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                // Sort Dropdown
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: selectedSortOption,
                    underline: const SizedBox(),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: isDark ? Colors.white : TColors.dark,
                    ),
                    dropdownColor: isDark ? Colors.grey[800] : Colors.white,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white : TColors.dark,
                      fontWeight: FontWeight.w500,
                    ),
                    items: [
                      'Newest',
                      'Name',
                      'Price: Low to High',
                      'Price: High to Low',
                      'Discount',
                      'Popularity',
                    ].map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedSortOption = newValue;
                        });
                      }
                    },
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
                  "\${product['price']}",
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