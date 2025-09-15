import 'package:get/get.dart';

// First, update your CartItem class to be more robust
class CartItem {
  final String id;
  final String name;
  final double price;
  final String image;
  int quantity;
  final String size;
  final String color;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.size,
    required this.color,
  });

  // Helper method to create CartItem from product data
  factory CartItem.fromProduct({
    required String productId,
    required String productName,
    required double productPrice,
    required String productImage,
    String size = 'M',
    String color = 'Default',
    int quantity = 1,
  }) {
    return CartItem(
      id: productId,
      name: productName,
      price: productPrice,
      image: productImage,
      quantity: quantity,
      size: size,
      color: color,
    );
  }

  // Create a copy with updated quantity
  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      price: price,
      image: image,
      quantity: quantity ?? this.quantity,
      size: size,
      color: color,
    );
  }
}

// Cart Controller for state management
class CartController extends GetxController {
  // Observable list of cart items
  final RxList<CartItem> _cartItems = <CartItem>[].obs;

  // Getters
  List<CartItem> get cartItems => _cartItems.toList();
  int get itemCount => _cartItems.length;
  int get totalQuantity => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Calculated totals
  double get subtotal => _cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  double get shipping => subtotal > 500 ? 0.0 : 15.0;
  double get tax => subtotal * 0.08;
  double get total => subtotal + shipping + tax;

  // Check if item is in cart
  bool isInCart(String productId) {
    return _cartItems.any((item) => item.id == productId);
  }

  // Add item to cart
  void addToCart(CartItem item) {
    final existingIndex = _cartItems.indexWhere((cartItem) => 
        cartItem.id == item.id && 
        cartItem.size == item.size && 
        cartItem.color == item.color);

    if (existingIndex != -1) {
      // Item already exists, update quantity
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + item.quantity,
      );
    } else {
      // Add new item
      _cartItems.add(item);
    }

    // Show success message
    Get.snackbar(
      'Added to Cart',
      '${item.name} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: Get.theme.colorScheme.primary.withOpacity(0.1),
      colorText: Get.theme.colorScheme.onSurface,
    );
  }

  // Remove item from cart
  void removeFromCart(String itemId) {
    final removedItem = _cartItems.firstWhereOrNull((item) => item.id == itemId);
    _cartItems.removeWhere((item) => item.id == itemId);
    
    if (removedItem != null) {
      Get.snackbar(
        'Removed from Cart',
        '${removedItem.name} has been removed from your cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.1),
        colorText: Get.theme.colorScheme.onSurface,
      );
    }
  }

  // Update item quantity
  void updateQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(itemId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _cartItems[index] = _cartItems[index].copyWith(quantity: newQuantity);
    }
  }

  // Clear entire cart
  void clearCart() {
    _cartItems.clear();
    Get.snackbar(
      'Cart Cleared',
      'All items have been removed from your cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: Get.theme.colorScheme.error.withOpacity(0.1),
      colorText: Get.theme.colorScheme.onSurface,
    );
  }

  // Quick add method for simple products (when you don't have all details)
  void quickAddToCart({
    required String productId,
    required String productName,
    required double productPrice,
    String productImage = 'https://via.placeholder.com/150',
    String size = 'M',
    String color = 'Default',
    int quantity = 1,
  }) {
    final cartItem = CartItem.fromProduct(
      productId: productId,
      productName: productName,
      productPrice: productPrice,
      productImage: productImage,
      size: size,
      color: color,
      quantity: quantity,
    );
    
    addToCart(cartItem);
  }
}