class Rating {
  final int id;
  final int userId;
  final int productId; 
  final int orderItemId; 
  final int ratingValue;
  final String? ulasan; 

  Rating({
    required this.id,
    required this.userId,
    required this.productId,
    required this.orderItemId,
    required this.ratingValue,
    this.ulasan,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      productId: json['product_id'] as int,
      orderItemId: json['order_item_id'] as int,
      ratingValue: json['rating'] as int, 
      ulasan: json['ulasan'] as String?, 
    );
  }
}