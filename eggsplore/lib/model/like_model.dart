class Like {
  final int productId;
  final bool userLiked;
  final int totalLikes;

  Like({
    required this.productId,
    required this.userLiked,
    required this.totalLikes,
  });

  factory Like.fromJson(Map<String, dynamic> json, int productId) {
    return Like(
      productId: productId,
      userLiked: json['user_liked'] ?? false,
      totalLikes: json['total_likes'] ?? 0,
    );
  }
}
