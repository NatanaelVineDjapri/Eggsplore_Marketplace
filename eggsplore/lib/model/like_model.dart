class Like {
  final int productId;
  final int totalLikes;
  final bool userLiked;

  Like({
    required this.productId,
    required this.totalLikes,
    required this.userLiked,
  });

  factory Like.fromJson(Map<String, dynamic> json, int productId) {
    return Like(
      productId: productId,
      totalLikes: json['total_likes'] ?? 0,
      userLiked: json['user_liked'] ?? false,
    );
  }
}
