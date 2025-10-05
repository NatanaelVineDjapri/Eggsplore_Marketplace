import 'package:eggsplore/model/order_item.dart';

class Order {
  final int id;
  final int userId;
  final double totalAmount;
  final String status;
  final String receiverName;
  final List<OrderItem> items;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.receiverName,
    required this.items,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var itemList = json['items'] as List;
    List<OrderItem> items = itemList.map((i) => OrderItem.fromJson(i)).toList();

    return Order(
      id: json['id'],
      userId: json['user_id'],
      totalAmount: double.parse(json['total_amount'].toString()),
      status: json['status'],
      receiverName: json['receiver_name'],
      items: items,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}