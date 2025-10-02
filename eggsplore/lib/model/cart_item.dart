class CartItem {
  final int id;
  final int productId;
  final String? name; 
  final String? shopName; 
  final double price;
  final int quantity;
  final String? image;

  CartItem({
    required this.id,
    required this.productId,
    this.name,
    this.shopName,
    required this.price,
    required this.quantity,
    this.image,
  });

  CartItem copyWith({
    int? quantity,
    String? name,
    String? shopName,
    double? price,
    String? image,
  }) {
    return CartItem(
      id: id,
      productId: productId,
      name: name ?? this.name,
      shopName: shopName ?? this.shopName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>?;
    final shop = product != null
        ? product['shop'] as Map<String, dynamic>?
        : null;

    return CartItem(
      id: json['id'] is int ? json['id'] : 0,
      productId: product != null && product['id'] is int ? product['id'] : 0,
      name: product != null && product['name'] is String
          ? product['name']
          : null,
      shopName: shop != null && shop['name'] is String
          ? shop['name']
          : "Toko Tidak Diketahui",
      price: product != null && product['price'] != null
          ? double.tryParse(product['price'].toString()) ?? 0.0
          : 0.0,
      quantity: json['quantity'] is int ? json['quantity'] : 1,
      image: product != null && product['image'] is String
          ? product['image']
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'name': name,
      'shop_name': shopName,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }
}
