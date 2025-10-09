import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/authentication/screens/wishlist/wishlist_controller.dart';
import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandShowcase extends StatelessWidget {
  const BrandShowcase({
    super.key,
    required this.brandName,
    required this.category,
  });

  final String brandName;
  final String category;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final CartController cartController = Get.find<CartController>();
    final WishlistController wishlistController = Get.find<WishlistController>();

    // Get all products for this brand
    final brandProducts = _getBrandProducts();
    final featuredImages = _getFeaturedImages();

    return Scaffold(
      appBar: TAppBar(
        title: Text(brandName),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand Header Card
              Container(
                padding: const EdgeInsets.all(TSizes.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border.all(
                    color: isDark ? TColors.darkGrey : TColors.grey,
                  ),
                  borderRadius: BorderRadius.circular(TSizes.productImageRadius),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(TSizes.sm),
                          decoration: BoxDecoration(
                            color: isDark ? TColors.darkGrey : TColors.light,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.storefront,
                            size: 32,
                            color: TColors.primary,
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    brandName,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: TSizes.xs),
                                  const Icon(
                                    Icons.verified,
                                    color: TColors.primary,
                                    size: 20,
                                  ),
                                ],
                              ),
                              Text(
                                '${brandProducts.length} Products',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: isDark ? TColors.grey : TColors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    // Featured Products Preview
                    if (featuredImages.isNotEmpty) ...[
                      const SizedBox(height: TSizes.spaceBtwItems),
                      SizedBox(
                        height: 80,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: featuredImages.length,
                          separatorBuilder: (context, index) => const SizedBox(width: TSizes.sm),
                          itemBuilder: (context, index) {
                            return Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: isDark ? Colors.grey[800] : TColors.light,
                                border: Border.all(
                                  color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                                  width: 0.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  featuredImages[index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.image_not_supported_outlined,
                                      color: isDark ? Colors.grey[600] : Colors.grey[400],
                                      size: 24,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              const SizedBox(height: TSizes.spaceBtwSections),
              
              // Products Section
              TSectionHeading(
                title: '$brandName Products',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              
              // Products Grid
              GridView.builder(
                itemCount: brandProducts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: TSizes.gridViewSpacing,
                  crossAxisSpacing: TSizes.gridViewSpacing,
                  mainAxisExtent: 280,
                ),
                itemBuilder: (context, index) {
                  final product = brandProducts[index];
                  return _buildProductCard(
                    context,
                    product,
                    isDark,
                    cartController,
                    wishlistController,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getBrandProducts() {
    final allProducts = {
      'Nike': [
        {
          'id': 'sport_nike_airmax_1',
          'name': 'Nike Air Max Pro',
          'brand': 'Nike',
          'price': 120.99,
          'originalPrice': 150.99,
          'discount': 20,
          'image': 'assets/images/products/nike-shoes.png',
        },
        {
          'id': 'sport_nike_airmax_2',
          'name': 'Nike Air Max Classic',
          'brand': 'Nike',
          'price': 130.99,
          'originalPrice': 160.99,
          'discount': 19,
          'image': 'assets/images/products/NikeAirMax.png',
        },
        {
          'id': 'sport_nike_tracksuit_1',
          'name': 'Nike Tracksuit Blue',
          'brand': 'Nike',
          'price': 89.99,
          'originalPrice': 110.99,
          'discount': 19,
          'image': 'assets/images/products/tracksuit_blue.png',
        },
        {
          'id': 'sport_nike_tracksuit_2',
          'name': 'Nike Tracksuit Black',
          'brand': 'Nike',
          'price': 94.99,
          'originalPrice': 115.99,
          'discount': 18,
          'image': 'assets/images/products/tracksuit_black.png',
        },
        {
          'id': 'sport_nike_tracksuit_3',
          'name': 'Nike Tracksuit Red',
          'brand': 'Nike',
          'price': 89.99,
          'originalPrice': 109.99,
          'discount': 18,
          'image': 'assets/images/products/tracksuit_red.png',
        },
        {
          'id': 'sport_nike_wildhorse_1',
          'name': 'Nike Wildhorse Trail',
          'brand': 'Nike',
          'price': 135.99,
          'originalPrice': 169.99,
          'discount': 20,
          'image': 'assets/images/products/NikeWildhorse.png',
        },
        {
          'id': 'sport_nike_basketball_1',
          'name': 'Nike Basketball Shoe',
          'brand': 'Nike',
          'price': 145.99,
          'originalPrice': 189.99,
          'discount': 23,
          'image': 'assets/images/products/NikeBasketballShoeGreenBlack.png',
        },
        {
          'id': 'sport_nike_slippers_1',
          'name': 'Nike Sport Slippers',
          'brand': 'Nike',
          'price': 39.99,
          'originalPrice': 54.99,
          'discount': 27,
          'image': 'assets/images/products/product-slippers.png',
        },
      ],
      'Jordan': [
        {
          'id': 'sport_jordan_blackred_1',
          'name': 'Air Jordan Black Red',
          'brand': 'Jordan',
          'price': 189.99,
          'originalPrice': 239.99,
          'discount': 21,
          'image': 'assets/images/products/NikeAirJOrdonBlackRed.png',
        },
        {
          'id': 'sport_jordan_orange_1',
          'name': 'Air Jordan Orange',
          'brand': 'Jordan',
          'price': 179.99,
          'originalPrice': 229.99,
          'discount': 22,
          'image': 'assets/images/products/NikeAirJOrdonOrange.png',
        },
        {
          'id': 'sport_jordan_whitemagenta_1',
          'name': 'Air Jordan White Magenta',
          'brand': 'Jordan',
          'price': 199.99,
          'originalPrice': 249.99,
          'discount': 20,
          'image': 'assets/images/products/NikeAirJordonwhiteMagenta.png',
        },
        {
          'id': 'sport_jordan_whitered_1',
          'name': 'Air Jordan White Red',
          'brand': 'Jordan',
          'price': 194.99,
          'originalPrice': 244.99,
          'discount': 20,
          'image': 'assets/images/products/NikeAirJOrdonWhiteRed.png',
        },
        {
          'id': 'sport_jordan_singleblue_1',
          'name': 'Air Jordan Single Blue',
          'brand': 'Jordan',
          'price': 184.99,
          'originalPrice': 234.99,
          'discount': 21,
          'image': 'assets/images/products/NikeAirJordonSingleBlue.png',
        },
      ],
      'Puma': [
        {
          'id': 'sport_puma_shoes_1',
          'name': 'Puma Running Shoes',
          'brand': 'Puma',
          'price': 89.99,
          'originalPrice': 119.99,
          'discount': 25,
          'image': 'assets/images/products/product-1.png',
        },
        {
          'id': 'sport_puma_jacket_1',
          'name': 'Puma Sport Jacket',
          'brand': 'Puma',
          'price': 79.99,
          'originalPrice': 99.99,
          'discount': 20,
          'image': 'assets/images/products/product-jacket.png',
        },
        {
          'id': 'sport_puma_cricket_1',
          'name': 'Puma Cricket Bat',
          'brand': 'Puma',
          'price': 65.99,
          'originalPrice': 89.99,
          'discount': 27,
          'image': 'assets/images/products/cricket_bat.png',
        },
        {
          'id': 'sport_puma_tennis_1',
          'name': 'Puma Tennis Racket',
          'brand': 'Puma',
          'price': 55.99,
          'originalPrice': 75.99,
          'discount': 26,
          'image': 'assets/images/products/tennis_racket.png',
        },
      ],
      'Adidas': [
        {
          'id': 'sport_adidas_football_1',
          'name': 'Adidas Football',
          'brand': 'Adidas',
          'price': 45.99,
          'originalPrice': 55.99,
          'discount': 18,
          'image': 'assets/images/products/Adidas_Football.png',
        },
        {
          'id': 'sport_adidas_baseball_1',
          'name': 'Adidas Baseball Bat',
          'brand': 'Adidas',
          'price': 75.99,
          'originalPrice': 95.99,
          'discount': 21,
          'image': 'assets/images/products/baseball_bat.png',
        },
        {
          'id': 'sport_adidas_jacket_1',
          'name': 'Adidas Sports Jacket',
          'brand': 'Adidas',
          'price': 95.99,
          'originalPrice': 120.99,
          'discount': 21,
          'image': 'assets/images/products/product-jacket.png',
        },
        {
          'id': 'sport_adidas_tracksuit_1',
          'name': 'Adidas Tracksuit Green',
          'brand': 'Adidas',
          'price': 99.99,
          'originalPrice': 129.99,
          'discount': 23,
          'image': 'assets/images/products/trcksuit_parrotgreen.png',
        },
        {
          'id': 'sport_adidas_slippers_1',
          'name': 'Adidas Comfort Slippers',
          'brand': 'Adidas',
          'price': 34.99,
          'originalPrice': 49.99,
          'discount': 30,
          'image': 'assets/images/products/slipper-product-1.png',
        },
        {
          'id': 'sport_adidas_slippers_2',
          'name': 'Adidas Sport Slippers',
          'brand': 'Adidas',
          'price': 36.99,
          'originalPrice': 49.99,
          'discount': 26,
          'image': 'assets/images/products/slipper-product-2.png',
        },
      ],
      'IKEA': [
        {
          'id': 'furniture_ikea_sofa_1',
          'name': 'IKEA Modern Sofa',
          'brand': 'IKEA',
          'price': 299.99,
          'originalPrice': 399.99,
          'discount': 25,
          'image': 'assets/images/products/bedroom_sofa.png',
        },
        {
          'id': 'furniture_ikea_lamp_1',
          'name': 'IKEA Modern Lamp',
          'brand': 'IKEA',
          'price': 49.99,
          'originalPrice': 69.99,
          'discount': 29,
          'image': 'assets/images/products/bedroom_lamp.png',
        },
        {
          'id': 'furniture_ikea_bed_1',
          'name': 'IKEA Bedroom Bed',
          'brand': 'IKEA',
          'price': 349.99,
          'originalPrice': 449.99,
          'discount': 22,
          'image': 'assets/images/products/bedroom_bed.png',
        },
        {
          'id': 'furniture_ikea_wardrobe_1',
          'name': 'IKEA Bedroom Wardrobe',
          'brand': 'IKEA',
          'price': 499.99,
          'originalPrice': 649.99,
          'discount': 23,
          'image': 'assets/images/products/bedroom_wardrobe.png',
        },
        {
          'id': 'furniture_ikea_bed_black_1',
          'name': 'IKEA Black Bed Frame',
          'brand': 'IKEA',
          'price': 379.99,
          'originalPrice': 479.99,
          'discount': 21,
          'image': 'assets/images/products/bedroom_bed_black.png',
        },
        {
          'id': 'furniture_ikea_bed_grey_1',
          'name': 'IKEA Grey Bed Set',
          'brand': 'IKEA',
          'price': 399.99,
          'originalPrice': 519.99,
          'discount': 23,
          'image': 'assets/images/products/bedroom_bed_grey.png',
        },
        {
          'id': 'furniture_ikea_counter_1',
          'name': 'IKEA Kitchen Counter',
          'brand': 'IKEA',
          'price': 599.99,
          'originalPrice': 799.99,
          'discount': 25,
          'image': 'assets/images/products/kitchen_counter.png',
        },
        {
          'id': 'furniture_ikea_fridge_1',
          'name': 'IKEA Refrigerator',
          'brand': 'IKEA',
          'price': 899.99,
          'originalPrice': 1199.99,
          'discount': 25,
          'image': 'assets/images/products/kitchen_refrigerator.png',
        },
      ],
      'Herman Miller': [
        {
          'id': 'furniture_hm_chair_1',
          'name': 'Herman Miller Office Chair Pro',
          'brand': 'Herman Miller',
          'price': 799.99,
          'originalPrice': 999.99,
          'discount': 20,
          'image': 'assets/images/products/office_chair_1.png',
        },
        {
          'id': 'furniture_hm_chair_2',
          'name': 'Herman Miller Ergonomic Chair',
          'brand': 'Herman Miller',
          'price': 849.99,
          'originalPrice': 1099.99,
          'discount': 23,
          'image': 'assets/images/products/office_chair_2.png',
        },
        {
          'id': 'furniture_hm_desk_1',
          'name': 'Herman Miller Office Desk',
          'brand': 'Herman Miller',
          'price': 699.99,
          'originalPrice': 899.99,
          'discount': 22,
          'image': 'assets/images/products/office_desk_1.png',
        },
        {
          'id': 'furniture_hm_desk_2',
          'name': 'Herman Miller Standing Desk',
          'brand': 'Herman Miller',
          'price': 899.99,
          'originalPrice': 1199.99,
          'discount': 25,
          'image': 'assets/images/products/office_desk_2.png',
        },
        {
          'id': 'furniture_hm_bed_1',
          'name': 'Herman Miller Luxury Bed',
          'brand': 'Herman Miller',
          'price': 1299.99,
          'originalPrice': 1699.99,
          'discount': 24,
          'image': 'assets/images/products/bedroom_bed_with_comforter.png',
        },
        {
          'id': 'furniture_hm_bed_2',
          'name': 'Herman Miller Simple Bed',
          'brand': 'Herman Miller',
          'price': 899.99,
          'originalPrice': 1199.99,
          'discount': 25,
          'image': 'assets/images/products/bedroom_bed_simple_brown.png',
        },
      ],
      'Kenwood': [
        {
          'id': 'furniture_kenwood_table_1',
          'name': 'Kenwood Dining Table',
          'brand': 'Kenwood',
          'price': 549.99,
          'originalPrice': 749.99,
          'discount': 27,
          'image': 'assets/images/products/kitchen_dining table.png',
        },
        {
          'id': 'furniture_kenwood_counter_1',
          'name': 'Kenwood Kitchen Counter',
          'brand': 'Kenwood',
          'price': 449.99,
          'originalPrice': 599.99,
          'discount': 25,
          'image': 'assets/images/products/kitchen_counter.png',
        },
        {
          'id': 'furniture_kenwood_sofa_1',
          'name': 'Kenwood Luxury Sofa',
          'brand': 'Kenwood',
          'price': 799.99,
          'originalPrice': 999.99,
          'discount': 20,
          'image': 'assets/images/products/bedroom_sofa.png',
        },
        {
          'id': 'furniture_kenwood_wardrobe_1',
          'name': 'Kenwood Modern Wardrobe',
          'brand': 'Kenwood',
          'price': 649.99,
          'originalPrice': 849.99,
          'discount': 24,
          'image': 'assets/images/products/bedroom_wardrobe.png',
        },
      ],
      'Apple': [
        {
          'id': 'electronics_apple_iphone13_1',
          'name': 'iPhone 13 Pro',
          'brand': 'Apple',
          'price': 999.99,
          'originalPrice': 1199.99,
          'discount': 17,
          'image': 'assets/images/products/iphone_13_pro.png',
        },
        {
          'id': 'electronics_apple_iphone14_1',
          'name': 'iPhone 14 Pro',
          'brand': 'Apple',
          'price': 1099.99,
          'originalPrice': 1299.99,
          'discount': 15,
          'image': 'assets/images/products/iphone_14_pro.png',
        },
        {
          'id': 'electronics_apple_iphone14_white_1',
          'name': 'iPhone 14 White',
          'brand': 'Apple',
          'price': 999.99,
          'originalPrice': 1199.99,
          'discount': 17,
          'image': 'assets/images/products/iphone_14_white.png',
        },
        {
          'id': 'electronics_apple_iphone12_red_1',
          'name': 'iPhone 12 Red',
          'brand': 'Apple',
          'price': 799.99,
          'originalPrice': 999.99,
          'discount': 20,
          'image': 'assets/images/products/iphone_12_red.png',
        },
        {
          'id': 'electronics_apple_iphone12_blue_1',
          'name': 'iPhone 12 Blue',
          'brand': 'Apple',
          'price': 799.99,
          'originalPrice': 999.99,
          'discount': 20,
          'image': 'assets/images/products/iphone_12_blue.png',
        },
        {
          'id': 'electronics_apple_iphone8_1',
          'name': 'iPhone 8 Classic',
          'brand': 'Apple',
          'price': 449.99,
          'originalPrice': 599.99,
          'discount': 25,
          'image': 'assets/images/products/iphone8_mobile.png',
        },
      ],
      'Samsung': [
        {
          'id': 'electronics_samsung_s9_1',
          'name': 'Samsung Galaxy S9',
          'brand': 'Samsung',
          'price': 299.99,
          'originalPrice': 399.99,
          'discount': 25,
          'image': 'assets/images/products/samsung_s9_mobile.png',
        },
        {
          'id': 'electronics_samsung_s9_special_1',
          'name': 'Samsung S9 Special Edition',
          'brand': 'Samsung',
          'price': 349.99,
          'originalPrice': 449.99,
          'discount': 22,
          'image': 'assets/images/products/samsung_s9_mobile_withback.png',
        },
        {
          'id': 'electronics_samsung_fridge_1',
          'name': 'Samsung Smart Refrigerator',
          'brand': 'Samsung',
          'price': 1299.99,
          'originalPrice': 1699.99,
          'discount': 24,
          'image': 'assets/images/products/kitchen_refrigerator.png',
        },
        {
          'id': 'electronics_samsung_counter_1',
          'name': 'Samsung Smart Counter',
          'brand': 'Samsung',
          'price': 699.99,
          'originalPrice': 899.99,
          'discount': 22,
          'image': 'assets/images/products/kitchen_counter.png',
        },
      ],
      'Acer': [
        {
          'id': 'electronics_acer_laptop_1',
          'name': 'Acer Gaming Laptop',
          'brand': 'Acer',
          'price': 799.99,
          'originalPrice': 999.99,
          'discount': 20,
          'image': 'assets/images/products/acer_laptop_1.png',
        },
        {
          'id': 'electronics_acer_laptop_2',
          'name': 'Acer Professional Laptop',
          'brand': 'Acer',
          'price': 899.99,
          'originalPrice': 1199.99,
          'discount': 25,
          'image': 'assets/images/products/acer_laptop_var_2.png',
        },
        {
          'id': 'electronics_acer_laptop_3',
          'name': 'Acer Ultrabook',
          'brand': 'Acer',
          'price': 699.99,
          'originalPrice': 899.99,
          'discount': 22,
          'image': 'assets/images/products/acer_laptop_3.png',
        },
        {
          'id': 'electronics_acer_laptop_4',
          'name': 'Acer Aspire Series',
          'brand': 'Acer',
          'price': 649.99,
          'originalPrice': 849.99,
          'discount': 24,
          'image': 'assets/images/products/acer_laptop_4.png',
        },
        {
          'id': 'electronics_acer_laptop_var1',
          'name': 'Acer Swift 3',
          'brand': 'Acer',
          'price': 749.99,
          'originalPrice': 949.99,
          'discount': 21,
          'image': 'assets/images/products/acer_laptop_var_1.png',
        },
        {
          'id': 'electronics_acer_laptop_var3',
          'name': 'Acer Nitro Gaming',
          'brand': 'Acer',
          'price': 999.99,
          'originalPrice': 1299.99,
          'discount': 23,
          'image': 'assets/images/products/acer_laptop_var_3.png',
        },
        {
          'id': 'electronics_acer_laptop_var4',
          'name': 'Acer Predator Series',
          'brand': 'Acer',
          'price': 1199.99,
          'originalPrice': 1599.99,
          'discount': 25,
          'image': 'assets/images/products/acer_laptop_var_4.png',
        },
        {
          'id': 'electronics_acer_laptop_standard',
          'name': 'Acer Standard Laptop',
          'brand': 'Acer',
          'price': 599.99,
          'originalPrice': 799.99,
          'discount': 25,
          'image': 'assets/images/products/acer_laptop_2.png',
        },
      ],
      'Zara': [
        {
          'id': 'clothes_zara_blue_shirt_1',
          'name': 'Zara Blue Cotton Shirt',
          'brand': 'Zara',
          'price': 39.99,
          'originalPrice': 59.99,
          'discount': 33,
          'image': 'assets/images/products/product-shirt_blue_2.png',
        },
        {
          'id': 'clothes_zara_blue_shirt_2',
          'name': 'Zara Classic Blue Shirt',
          'brand': 'Zara',
          'price': 44.99,
          'originalPrice': 64.99,
          'discount': 31,
          'image': 'assets/images/products/product-shirt_blue_1.png',
        },
        {
          'id': 'clothes_zara_jeans_1',
          'name': 'Zara Classic Blue Jeans',
          'brand': 'Zara',
          'price': 79.99,
          'originalPrice': 99.99,
          'discount': 20,
          'image': 'assets/images/products/product-jeans.png',
        },
        {
          'id': 'clothes_zara_shirt_1',
          'name': 'Zara Classic Shirt',
          'brand': 'Zara',
          'price': 49.99,
          'originalPrice': 69.99,
          'discount': 29,
          'image': 'assets/images/products/product-shirt.png',
        },
        {
          'id': 'clothes_zara_tshirt_red',
          'name': 'Zara Red Collar T-Shirt',
          'brand': 'Zara',
          'price': 29.99,
          'originalPrice': 39.99,
          'discount': 25,
          'image': 'assets/images/products/tshirt_red_collar.png',
        },
        {
          'id': 'clothes_zara_tshirt_green',
          'name': 'Zara Green Collar T-Shirt',
          'brand': 'Zara',
          'price': 29.99,
          'originalPrice': 39.99,
          'discount': 25,
          'image': 'assets/images/products/tshirt_green_collar.png',
        },
        {
          'id': 'clothes_zara_tshirt_blue',
          'name': 'Zara Blue Collar T-Shirt',
          'brand': 'Zara',
          'price': 29.99,
          'originalPrice': 39.99,
          'discount': 25,
          'image': 'assets/images/products/tshirt_blue_collar.png',
        },
      ],
      'H&M': [
        {
          'id': 'clothes_hm_leather_jacket_1',
          'name': 'H&M Premium Leather Jacket',
          'brand': 'H&M',
          'price': 149.99,
          'originalPrice': 199.99,
          'discount': 25,
          'image': 'assets/images/products/leather_jacket_4.png',
        },
        {
          'id': 'clothes_hm_leather_jacket_2',
          'name': 'H&M Classic Leather Jacket',
          'brand': 'H&M',
          'price': 139.99,
          'originalPrice': 189.99,
          'discount': 26,
          'image': 'assets/images/products/leather_jacket_1.png',
        },
        {
          'id': 'clothes_hm_leather_jacket_3',
          'name': 'H&M Biker Jacket',
          'brand': 'H&M',
          'price': 159.99,
          'originalPrice': 209.99,
          'discount': 24,
          'image': 'assets/images/products/leather_jacket_2.png',
        },
        {
          'id': 'clothes_hm_tshirt_blue_1',
          'name': 'H&M Blue T-Shirt',
          'brand': 'H&M',
          'price': 24.99,
          'originalPrice': 34.99,
          'discount': 29,
          'image': 'assets/images/products/tshirt_blue_without_collar_front.png',
        },
        {
          'id': 'clothes_hm_tshirt_yellow_1',
          'name': 'H&M Yellow Collar T-Shirt',
          'brand': 'H&M',
          'price': 29.99,
          'originalPrice': 39.99,
          'discount': 25,
          'image': 'assets/images/products/tshirt_yellow_collar.png',
        },
        {
          'id': 'clothes_hm_slippers_1',
          'name': 'H&M Comfort Slippers',
          'brand': 'H&M',
          'price': 34.99,
          'originalPrice': 49.99,
          'discount': 30,
          'image': 'assets/images/products/slipper-product-3.png',
        },
      ],
    };

    return allProducts[brandName] ?? [];
  }

  List<String> _getFeaturedImages() {
    final brandImages = {
      'Nike': [
        'assets/images/products/NikeAirMax.png',
        'assets/images/products/nike-shoes.png',
        'assets/images/products/tracksuit_blue.png',
      ],
      'Jordan': [
        'assets/images/products/NikeAirJOrdonBlackRed.png',
        'assets/images/products/NikeAirJOrdonOrange.png',
        'assets/images/products/NikeAirJordonwhiteMagenta.png',
      ],
      'Puma': [
        'assets/images/products/product-1.png',
        'assets/images/products/product-jacket.png',
        'assets/images/products/cricket_bat.png',
      ],
      'Adidas': [
        'assets/images/products/Adidas_Football.png',
        'assets/images/products/baseball_bat.png',
        'assets/images/products/product-jacket.png',
      ],
      'IKEA': [
        'assets/images/products/bedroom_sofa.png',
        'assets/images/products/bedroom_bed_black.png',
        'assets/images/products/bedroom_lamp.png',
      ],
      'Herman Miller': [
        'assets/images/products/office_chair_1.png',
        'assets/images/products/office_desk_1.png',
        'assets/images/products/bedroom_bed_with_comforter.png',
      ],
      'Kenwood': [
        'assets/images/products/kitchen_dining table.png',
        'assets/images/products/bedroom_sofa.png',
        'assets/images/products/bedroom_wardrobe.png',
      ],
      'Apple': [
        'assets/images/products/iphone_14_pro.png',
        'assets/images/products/iphone_13_pro.png',
        'assets/images/products/iphone_12_red.png',
      ],
      'Samsung': [
        'assets/images/products/samsung_s9_mobile.png',
        'assets/images/products/samsung_s9_mobile_withback.png',
        'assets/images/products/kitchen_refrigerator.png',
      ],
      'Acer': [
        'assets/images/products/acer_laptop_1.png',
        'assets/images/products/acer_laptop_var_2.png',
        'assets/images/products/acer_laptop_3.png',
      ],
      'Zara': [
        'assets/images/products/product-shirt_blue_2.png',
        'assets/images/products/product-jeans.png',
        'assets/images/products/product-shirt.png',
      ],
      'H&M': [
        'assets/images/products/leather_jacket_4.png',
        'assets/images/products/tshirt_blue_without_collar_front.png',
        'assets/images/products/tshirt_yellow_collar.png',
      ],
    };

    return brandImages[brandName] ?? [];
  }

  Widget _buildProductCard(
    BuildContext context,
    Map<String, dynamic> product,
    bool isDark,
    CartController cartController,
    WishlistController wishlistController,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(TSizes.productImageRadius),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(TSizes.productImageRadius),
                  ),
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.shopping_bag_outlined,
                        size: 48,
                        color: isDark ? Colors.grey[600] : Colors.grey[400],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product['name'],
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        product['brand'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                              fontSize: 11,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "\${product['price']}",
                            style:
                                Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: TColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                          ),
                          const SizedBox(width: 4),
                          if (product['originalPrice'] != null)
                            Flexible(
                              child: Text(
                                "\${product['originalPrice']}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.color
                                          ?.withOpacity(0.6),
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 10,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: double.infinity,
                        height: 28,
                        child: ElevatedButton(
                          onPressed: () {
                            _showAddToCartDialog(context, product, cartController);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                                fontSize: 9, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (product['discount'] > 0)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${product['discount']}% OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Positioned(
            top: 8,
            right: 8,
            child: Obx(() => Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.black.withOpacity(0.7)
                        : Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        wishlistController.toggleWishlist(product);
                      },
                      child: Icon(
                        wishlistController.isInWishlist(product['id'])
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 16,
                        color: wishlistController.isInWishlist(product['id'])
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ),
                )),
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
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                      '\$' + product['price'].toString(),
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
                      backgroundColor:
                          isDark ? Colors.grey[800] : Colors.grey[200],
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
                      backgroundColor:
                          isDark ? Colors.grey[800] : Colors.grey[200],
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
                              '${product['name']} ($selectedColor, $selectedSize) added to cart'),
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