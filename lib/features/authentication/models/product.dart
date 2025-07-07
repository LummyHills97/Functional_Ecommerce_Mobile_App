// lib/models/product.dart
class Product {
  final String id;
  final String title;
  final String brand;
  final String imageUrl;
  final double originalPrice;
  final double salePrice;

  const Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.imageUrl,
    required this.originalPrice,
    required this.salePrice,
  });
}
