import 'package:eggsplore/helper/image_helper.dart'; // Pastikan path ini benar

class Shop {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String image;
  final DateTime createdAt;

  Shop({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.image,
    required this.createdAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
      image: ImageHelper.getImageUrl(json['image']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
