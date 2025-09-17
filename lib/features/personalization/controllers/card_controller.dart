import 'package:get/get.dart';
import 'package:ecommerce_store/features/personalization/models/cart_item.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  int get itemCount => cartItems.length;
  int get totalQuantity => cartItems.fold(0, (sum, item) => sum + item.quantity);

  // ✅ Check if a product is already in the cart
  bool isInCart(String productId) {
    return cartItems.any((item) => item.id == productId);
  }

  void quickAddToCart({
    required String productId,
    required String productName,
    required double productPrice,
    required String productImage,
    String productSize = "Default",
    String productColor = "Default",
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
        size: productSize,
        color: productColor,
      ));
    }
  }

  void incrementQuantity(String id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index >= 0) {
      cartItems[index].quantity++;
      cartItems.refresh();
    }
  }

  void decrementQuantity(String id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index >= 0 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    }
  }

  void removeFromCart(String id) {
    cartItems.removeWhere((item) => item.id == id);
    update();
  }

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  double get shipping => cartItems.isEmpty ? 0 : 10.0;
  double get tax => subtotal * 0.05;
  double get total => subtotal + shipping + tax;
}
