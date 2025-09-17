import 'package:get/get.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  int get itemCount => cartItems.length;

  int get totalQuantity =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  void quickAddToCart({
    required String productId,
    required String productName,
    required double productPrice,
    required String productImage,
  }) {
    final existingIndex =
        cartItems.indexWhere((item) => item.id == productId);

    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(
        id: productId,
        name: productName,
        price: productPrice,
        image: productImage,
      ));
    }
  }

  bool isInCart(String productId) {
    return cartItems.any((item) => item.id == productId);
  }
}
