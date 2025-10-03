// lib/model/order.dart

import 'order_item.dart'; // Relasi ke item yang dibeli

class Order {
  final int id;
  final int userId;
  final String status;
  final double totalAmount;
  final String shippingAddress;
  final List<OrderItem> items; // Item-item dalam pesanan ini

  Order({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.shippingAddress,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemsJson = json['items'] ?? [];
    
    return Order(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      status: json['status'] as String,
      totalAmount: (json['total_amount'] as num).toDouble(),
      shippingAddress: json['shipping_address'] as String,
      // Memparsing order_items
      items: itemsJson.map((i) => OrderItem.fromJson(i)).toList(),
    );
  }
}