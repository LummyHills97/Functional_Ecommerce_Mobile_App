import 'package:get/get.dart';
import 'package:ecommerce_store/features/personalization/models/cart_item.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  // Getters
  int get itemCount => cartItems.length;
  int get totalQuantity => cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Check if a product is already in the cart
  bool isInCart(String productId) {
    return cartItems.any((item) => item.id == productId);
  }

  // Add item to cart - handles both new items and quantity increment
  void quickAddToCart({
  required String productId,
  required String productName,
  required double productPrice,
  required String productImage,
  String? productSize,
  String? productColor,
  String productBrand = "Default",
}) {
  final existingIndex = cartItems.indexWhere((item) => item.id == productId);

  if (existingIndex >= 0) {
    cartItems[existingIndex].quantity++;
    cartItems.refresh();
  } else {
    cartItems.add(CartItem(
      id: productId,
      name: productName,
      price: productPrice,
      image: productImage,
      size: productSize ?? "",   // 👈 empty instead of "Default"
      color: productColor ?? "", // 👈 empty instead of "Default"
      brand: productBrand,
    ));
  }

  _saveCartItems();
}


  // Increment quantity of existing item
  void incrementQuantity(String id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index >= 0) {
      cartItems[index].quantity++;
      cartItems.refresh();
      _saveCartItems();
    }
  }

  // Decrement quantity of existing item
  void decrementQuantity(String id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        cartItems.refresh();
      } else {
        // Remove item if quantity becomes 0
        removeFromCart(id);
        return;
      }
      _saveCartItems();
    }
  }

  // Remove item completely from cart
  void removeFromCart(String id) {
    cartItems.removeWhere((item) => item.id == id);
    _saveCartItems();
  }

  // Clear entire cart
  void clearCart() {
    cartItems.clear();
    _saveCartItems();
  }

  // Price calculations
  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  
  double get shipping => cartItems.isEmpty ? 0 : 10.0;
  
  double get tax => subtotal * 0.05; // 5% tax
  
  double get total => subtotal + shipping + tax;


  // Save cart items to persistent storage (implement as needed)
  void _saveCartItems() {
    // Implement persistent storage here if needed
    // For example, using SharedPreferences or local database
  }

  // Load cart items from persistent storage (implement as needed)
  void _loadCartItems() {
    // Implement loading from persistent storage here if needed
  }

  @override
  void onInit() {
    super.onInit();
    _loadCartItems();
  }
}
