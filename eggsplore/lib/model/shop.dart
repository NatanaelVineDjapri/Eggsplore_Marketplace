// lib/model/shop.dart
class Shop {
  final int id;
  final int userId;
  final String name;
  final String description;
  final DateTime createdAt;

  Shop({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'], // Sesuaikan dengan key 'name' dari backend
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
