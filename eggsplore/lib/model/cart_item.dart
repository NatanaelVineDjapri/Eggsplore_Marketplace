class CartItem {
  final int id;
  final int? productId;
  final String name;
  final double price;
  final String? image;
  final int quantity;
  final int subtotal;

  CartItem({
    required this.id,
    this.productId,
    required this.name,
    required this.price,
    this.image,
    required this.quantity,
    required this.subtotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final product = json['product'] ?? {};
    return CartItem(
      id: json['id'] ?? 0,
      productId: product['id'],
      name: product['name'] ?? '',
      price: double.tryParse(product['price']?.toString() ?? '0') ?? 0,
      image: product['image'],
      quantity: json['quantity'] ?? 0,
      subtotal: json['subtotal'] ?? 0,
    );
  }

  // ✅ Tambahin copyWith
  CartItem copyWith({
    int? id,
    int? productId,
    String? name,
    double? price,
    String? image,
    int? quantity,
    int? subtotal,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      subtotal: subtotal ?? this.subtotal,
    );
  }
}
