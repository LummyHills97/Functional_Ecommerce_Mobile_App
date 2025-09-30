import 'package:get/get.dart';
import 'package:ecommerce_store/features/personalization/models/cart_item.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  // -----------------------
  // Address & Payment state
  // -----------------------
  var selectedAddress = RxnString(); // null if not selected
  var selectedPaymentMethod = RxnString(); // null if not selected

  // -----------------------
  // Coupon & discount state
  // -----------------------
  var appliedCoupon = RxnString(); // null if no coupon
  var discount = 0.0.obs;

  // -----------------------
  // Cart logic
  // -----------------------
  int get itemCount => cartItems.length;
  int get totalQuantity => cartItems.fold(0, (sum, item) => sum + item.quantity);

  bool isInCart(String productId) {
    return cartItems.any((item) => item.id == productId);
  }

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
        size: productSize ?? "",
        color: productColor ?? "",
        brand: productBrand,
      ));
    }

    _saveCartItems();
    _recalculateDiscount(); // 👈 keep coupon active
  }

  void incrementQuantity(String id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index >= 0) {
      cartItems[index].quantity++;
      cartItems.refresh();
      _saveCartItems();
      _recalculateDiscount();
    }
  }

  void decrementQuantity(String id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        cartItems.refresh();
      } else {
        removeFromCart(id);
        return;
      }
      _saveCartItems();
      _recalculateDiscount();
    }
  }

  void removeFromCart(String id) {
    cartItems.removeWhere((item) => item.id == id);
    _saveCartItems();
    _recalculateDiscount();
  }

  void clearCart() {
    cartItems.clear();
    appliedCoupon.value = null;
    discount.value = 0.0;
    selectedAddress.value = null;
    selectedPaymentMethod.value = null;
    _saveCartItems();
  }

  // -----------------------
  // Price calculations
  // -----------------------
  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  double get shipping => cartItems.isEmpty ? 0 : 10.0;

  double get tax => subtotal * 0.05; // 5% tax

  double get total =>
      subtotal + shipping + tax - discount.value.clamp(0, double.infinity);

  // -----------------------
  // Coupon logic
  // -----------------------
  void applyCoupon(String code) {
    appliedCoupon.value = null;
    discount.value = 0.0;

    if (code.toUpperCase() == "SAVE10") {
      discount.value = subtotal * 0.10; // 10% off
      appliedCoupon.value = code;
    } else if (code.toUpperCase() == "FREESHIP") {
      discount.value = shipping; // remove shipping fee
      appliedCoupon.value = code;
    } else if (code.toUpperCase() == "WELCOME5") {
      discount.value = 5.0; // flat $5 off
      appliedCoupon.value = code;
    } else {
      Get.snackbar("Invalid Coupon", "The code you entered is not valid.");
    }
  }

  void _recalculateDiscount() {
    if (appliedCoupon.value != null) {
      applyCoupon(appliedCoupon.value!); // 👈 reapply the same coupon
    }
  }

  // -----------------------
  // Persistence
  // -----------------------
  void _saveCartItems() {
    // TODO: Implement persistent storage
  }

  void _loadCartItems() {
    // TODO: Implement persistent storage
  }

  @override
  void onInit() {
    super.onInit();
    _loadCartItems();
  }
}