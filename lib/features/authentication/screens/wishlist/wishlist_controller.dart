import 'package:get/get.dart';

class WishlistController extends GetxController {
  var wishlistItems = <Map<String, dynamic>>[].obs;

  // Check if product is in wishlist
  bool isInWishlist(String productId) {
    return wishlistItems.any((item) => item['id'].toString() == productId);
  }

  // Add or remove from wishlist (toggle)
  void toggleWishlist(Map<String, dynamic> product) {
    final productId = product['id'].toString();
    
    if (isInWishlist(productId)) {
      // Remove from wishlist
      wishlistItems.removeWhere((item) => item['id'].toString() == productId);
      Get.snackbar(
        'Removed from Wishlist',
        '${product['name']} removed from wishlist',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
    } else {
      // Add to wishlist
      wishlistItems.add({
        'id': product['id'],
        'name': product['name'],
        'brand': product['brand'],
        'price': product['price'],
        'originalPrice': product['originalPrice'],
        'discount': product['discount'],
        'image': product['image'],
        'isFavorite': true,
      });
      Get.snackbar(
        'Added to Wishlist',
        '${product['name']} added to wishlist',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
    }
  }

  // Remove item by index (for wishlist screen)
  void removeByIndex(int index) {
    if (index >= 0 && index < wishlistItems.length) {
      final item = wishlistItems[index];
      wishlistItems.removeAt(index);
      Get.snackbar(
        'Removed',
        '${item['name']} removed from wishlist',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
    }
  }

  // Clear all wishlist items
  void clearWishlist() {
    wishlistItems.clear();
    Get.snackbar(
      'Wishlist Cleared',
      'All items removed from wishlist',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  // Get wishlist count
  int get wishlistCount => wishlistItems.length;
}
