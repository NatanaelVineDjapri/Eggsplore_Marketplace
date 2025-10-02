import 'product.dart';

class CartItem {
  final int id;
  final int productId;
  final int quantity;
  final double price;
  final Product product;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      product: Product.fromJson(json['product']),
    );
  }

  CartItem copyWith({
    int? id,
    int? productId,
    int? quantity,
    double? price,
    Product? product,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      product: product ?? this.product,
    );
  }
}
