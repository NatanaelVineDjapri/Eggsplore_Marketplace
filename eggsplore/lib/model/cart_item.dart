class CartItem {
  final int id;
  final int productId;
  final String name;
  final String shopName;
  final double price;
  final int quantity;
  final String? image;
  final bool isSelected;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.shopName,
    required this.price,
    required this.quantity,
    this.image,
    this.isSelected = false, 
  });

  CartItem copyWith({
    int? quantity,
    String? name,
    String? shopName,
    double? price,
    String? image,
    bool? isSelected,
  }) {
    return CartItem(
      id: id,
      productId: productId,
      name: name ?? this.name,
      shopName: shopName ?? this.shopName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>?;
    final shop = product?['shop'] as Map<String, dynamic>?;

    return CartItem(
      id: json['id'] as int? ?? 0,
      productId: product?['id'] as int? ?? 0,
      name: product?['name'] as String? ?? "Produk tidak ditemukan",
      shopName: shop?['name'] as String? ?? "Toko Tidak Diketahui",
      price: product != null && product['price'] != null
          ? double.tryParse(product['price'].toString()) ?? 0.0
          : 0.0,
      quantity: json['quantity'] as int? ?? 1,
      image: product?['image'] as String?,
      isSelected: false,
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
