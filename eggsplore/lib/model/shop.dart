import 'package:eggsplore/helper/image_helper.dart';
import 'package:eggsplore/model/user.dart';

class Shop {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String? imagePath; 
  final DateTime createdAt;
  final User? user;
  final String? address;

  Shop({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    this.imagePath, 
    required this.createdAt,
    this.user,
    this.address,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
      imagePath: json['image'] as String, 
      createdAt: DateTime.parse(json['created_at']),
      address: json['address'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
