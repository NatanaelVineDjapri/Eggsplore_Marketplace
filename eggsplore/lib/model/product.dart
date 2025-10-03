class Product {
  final int id;
  final int shopId; 
  final String name;
  final String description;
  final double price;
  final int stock;
  final String image;
  final String userName;
  
  final bool hasPurchased;
  final bool hasReviewed;
  final double averageRating;

  Product({
    required this.id,
    required this.shopId, 
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.userName,
    this.hasPurchased = false,
    this.hasReviewed = false,
    this.averageRating = 0.0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final double parsedPrice = json['price'] is String
        ? double.tryParse(json['price']) ?? 0.0
        : (json['price'] as num?)?.toDouble() ?? 0.0;

    final double parsedAverageRating = 
        (json['average_rating'] as num?)?.toDouble() ?? 0.0;


    return Product(
      id: json['id'],
      shopId: json['shop_id'] ?? 0, 
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: parsedPrice,
      stock: json['stock'] ?? 0,
      image: json['image'] ?? '',
      userName: json['user']?['name'] ?? '', 
      hasPurchased: json['has_purchased'] ?? false,
      hasReviewed: json['has_reviewed'] ?? false,
      averageRating: parsedAverageRating,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "stock": stock,
      "image": image,
      // `shopId` biasanya tidak perlu dikirim saat membuat produk baru,
      // karena akan diambil dari user yang sedang login di backend.
    };
  }
}