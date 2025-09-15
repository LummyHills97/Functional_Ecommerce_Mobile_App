import 'package:ecommerce_store/features/personalization/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_store/features/personalization/screens/cart/widgets/cart.dart';
import 'package:ecommerce_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecommerce_store/features/authentication/screens/login/login.dart';
import 'package:ecommerce_store/navigation_menu.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/theme/theme.dart';
// Import your CartController
// import 'package:ecommerce_store/controllers/cart_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ecommerce Store',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,

      /// Initialize dependencies
      initialBinding: BindingsBuilder(() {
        // Make sure CartController is available app-wide
        Get.put(CartController(), permanent: true);
      }),

      /// Initial route
      initialRoute: '/onboarding',

      /// Defined routes
      getPages: [
        GetPage(
          name: '/onboarding',
          page: () => OnboardingScreen(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/navigation',
          page: () => const NavigationMenu(initialIndex: 0),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/cart',
          page: () => const CartScreen(),
          transition: Transition.rightToLeft,
        ),
      ],

      /// Fallback for unknown routes
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => const Scaffold(
          body: Center(
            child: Text('Page Not Found'),
          ),
        ),
      ),
    );
  }
}

// Example usage in your home page or product screen
class ExampleProductCard extends StatelessWidget {
  final String productId;
  final String productName;
  final double productPrice;
  final String productImage;

  const ExampleProductCard({
    super.key,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Card(
      child: Column(
        children: [
          // Product image
          Image.network(
            productImage,
            height: 150,
            fit: BoxFit.cover,
          ),

          // Product name
          Text(
            productName,
            style: Theme.of(context).textTheme.titleMedium,
          ),

          // Product price
          Text(
            '\$${productPrice.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),

          // Add to cart button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => ElevatedButton.icon(
                onPressed: () {
                  cartController.quickAddToCart(
                    productId: productId,
                    productName: productName,
                    productPrice: productPrice,
                    productImage: productImage,
                  );
                },
                icon: Icon(
                  cartController.isInCart(productId)
                      ? Icons.check
                      : Icons.add_shopping_cart,
                ),
                label: Text(
                  cartController.isInCart(productId)
                      ? "Added"
                      : "Add to Cart",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
