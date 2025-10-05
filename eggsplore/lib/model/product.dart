class Product {
  final int id;
  final int shopId;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String image;
  final String userName;
  final String shopName;
  final bool hasPurchased;
  final bool hasReviewed;
  final double averageRating;
  final String? shopImage;
  final String? imageUrl;

  Product({
    required this.id,
    required this.shopId,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.userName,
    required this.shopName,
    this.hasPurchased = false,
    this.hasReviewed = false,
    this.averageRating = 0.0,
    this.shopImage,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json['product'] != null
        ? Map<String, dynamic>.from(json['product'])
        : Map<String, dynamic>.from(json);

    final dynamic user = data['user'];
    final dynamic shop = data['shop'];

    final double parsedPrice = data['price'] is String
        ? double.tryParse(data['price']) ?? 0.0
        : (data['price'] as num?)?.toDouble() ?? 0.0;

    final double parsedAverageRating =
        (json['average_rating'] is num) ? (json['average_rating'] as num).toDouble() : 0.0;

    return Product(
      id: (data['id'] as num?)?.toInt() ?? 0,
      shopId: (data['shop_id'] as num?)?.toInt() ?? 0,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: parsedPrice,
      stock: (data['stock'] as num?)?.toInt() ?? 0,
      image: data['image'] ?? '',
      userName: user != null ? (user['name'] ?? '') : (data['user_name'] ?? ''),
      shopImage: user != null ? (user['image'] as String?) : null,
      shopName: shop != null
          ? (shop['name'] ?? '')
          : (user != null ? (user['shop_name'] ?? user['name'] ?? '') : (data['shop_name'] ?? '')),
      hasPurchased: data['has_purchased'] ?? false,
      hasReviewed: data['has_reviewed'] ?? false,
      imageUrl: data['image_url'] ?? data['image'],
      averageRating: parsedAverageRating,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "shop_id": shopId,
      "name": name,
      "description": description,
      "price": price,
      "stock": stock,
      "image": image,
      "user_name": userName,
      "shop_name": shopName,
      "has_purchased": hasPurchased,
      "has_reviewed": hasReviewed,
      "average_rating": averageRating,
      "shop_image": shopImage,
      "image_url": imageUrl,
    };
  }
}
