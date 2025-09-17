class CartItem {
  final String id;
  final String name;
  final String image;
  final String size;
  final String color;   // 👈 added
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.size,
    required this.color,  // 👈 added
    required this.price,
    required this.quantity,
  });

  // Optional: copyWith for easier updates
  CartItem copyWith({
    String? id,
    String? name,
    String? image,
    String? size,
    String? color,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      size: size ?? this.size,
      color: color ?? this.color,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
