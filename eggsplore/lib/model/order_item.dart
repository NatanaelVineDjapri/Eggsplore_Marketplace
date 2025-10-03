// lib/model/order_item.dart

import 'rating.dart'; // Import model Rating

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final String productName;
  final String shopName;
  final double priceAtPurchase;
  final int quantity;
  final Rating? rating; // Jika sudah di-review

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.shopName,
    required this.priceAtPurchase,
    required this.quantity,
    this.rating,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] as int,
      orderId: json['order_id'] as int,
      productId: json['product_id'] as int,
      productName: json['product_name'] as String,
      shopName: json['shop_name'] as String,
      priceAtPurchase: (json['price_at_purchase'] as num).toDouble(),
      quantity: json['quantity'] as int,
      // Memeriksa dan memparsing Rating (jika ada relasi 'review' di backend)
      rating: json['review'] != null ? Rating.fromJson(json['review']) : null,
    );
  }
}