class CartItem {
  final String id;
  final String name;
  final double price;
  final String image;
  final String? brand;  // ✅ Make sure this field exists
  final String? color;
  final String? size;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.brand,
    this.color,
    this.size,
    this.quantity = 1,
  });

  // Calculate total price for this item
  double get totalPrice => price * quantity;

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'brand': brand,
      'color': color,
      'size': size,
      'quantity': quantity,
    };
  }

  // Create from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      brand: json['brand'] as String?,
      color: json['color'] as String?,
      size: json['size'] as String?,
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  // Create a copy with modified fields
  CartItem copyWith({
    String? id,
    String? name,
    double? price,
    String? image,
    String? brand,
    String? color,
    String? size,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      brand: brand ?? this.brand,
      color: color ?? this.color,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  String toString() {
    return 'CartItem(id: $id, name: $name, brand: $brand, price: $price, color: $color, size: $size, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.id == id &&
        other.color == color &&
        other.size == size;
  }

  @override
  int get hashCode => Object.hash(id, color, size);
}