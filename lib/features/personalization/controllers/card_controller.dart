import 'package:get/get.dart';
import 'package:ecommerce_store/features/personalization/models/cart_item.dart';

class CartController extends GetxController {
  // -----------------------
  // Cart state
  // -----------------------
  var cartItems = <CartItem>[].obs;

  // -----------------------
  // Address & Payment state
  // -----------------------
  var selectedAddress = RxnString(); // null if not selected
  var selectedPaymentMethod = RxnString(); // null if not selected

  // -----------------------
  // Saved cards list
  // -----------------------
  final RxList<Map<String, String>> savedCards = <Map<String, String>>[].obs;

  void addCard(Map<String, String> card) {
    savedCards.add(card);
    // Optionally, save to local storage here
  }

  void removeCard(int index) {
    if (index >= 0 && index < savedCards.length) {
      savedCards.removeAt(index);
    }
  }

  Map<String, String>? getCard(int index) {
    if (index >= 0 && index < savedCards.length) {
      return savedCards[index];
    }
    return null;
  }

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
    required String productBrand,
    String? productSize,
    String? productColor,
  }) {
    final existingIndex = cartItems.indexWhere((item) =>
      item.id == productId &&
      item.size == productSize &&
      item.color == productColor
    );

    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(
        id: productId,
        name: productName,
        price: productPrice,
        image: productImage,
        brand: productBrand,
        size: productSize,
        color: productColor,
        quantity: 1,
      ));
    }

    _saveCartItems();
    _recalculateDiscount();
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
      Get.snackbar(
        "Coupon Applied!",
        "You saved \$${discount.value.toStringAsFixed(2)} with code $code",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (code.toUpperCase() == "FREESHIP") {
      discount.value = shipping; // remove shipping fee
      appliedCoupon.value = code;
      Get.snackbar(
        "Coupon Applied!",
        "Free shipping applied!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (code.toUpperCase() == "WELCOME5") {
      discount.value = 5.0; // flat $5 off
      appliedCoupon.value = code;
      Get.snackbar(
        "Coupon Applied!",
        "\$5 discount applied!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Invalid Coupon",
        "The code you entered is not valid.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeCoupon() {
    appliedCoupon.value = null;
    discount.value = 0.0;
  }

  void _recalculateDiscount() {
    if (appliedCoupon.value != null) {
      final currentCoupon = appliedCoupon.value!;
      appliedCoupon.value = null;
      discount.value = 0.0;
      applyCoupon(currentCoupon);
    }
  }

  // -----------------------
  // Persistence (stub)
  // -----------------------
  void _saveCartItems() {
    // TODO: Implement persistent storage with GetStorage or SharedPreferences
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