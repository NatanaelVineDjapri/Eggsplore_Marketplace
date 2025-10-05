import 'package:eggsplore/helper/image_helper.dart';

class Shop {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String image;
  final DateTime createdAt;
  final String? address; // opsional, bisa null kalau API ga ngirim

  Shop({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.image,
    required this.createdAt,
    this.address,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: ImageHelper.getImageUrl(json['image']),
      createdAt: DateTime.parse(json['created_at']),
      address: json['address'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "name": name,
      "description": description,
      "image": image,
      "created_at": createdAt.toIso8601String(),
      "address": address,
    };
  }
}
