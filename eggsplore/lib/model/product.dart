class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String image;
  final String userName;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.userName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] is String
          ? double.parse(json['price'])
          : (json['price'] as num).toDouble(),
      stock: json['stock'] ?? 0,
      image: json['image'] ?? '',
      userName: json['user']?['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "stock": stock,
      "image": image,
    };
  }
}
