class CartItem {
  final String id;
  final String name;
  final String image;
  final String brand;
  final String size;
  final String color;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    this.brand = "Default", // 👈 default to avoid errors
    required this.size,
    required this.color,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({
    String? id,
    String? name,
    String? image,
    String? brand,
    String? size,
    String? color,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      brand: brand ?? this.brand,
      size: size ?? this.size,
      color: color ?? this.color,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
