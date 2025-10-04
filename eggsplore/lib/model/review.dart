class Review {
  final int rating;
  final String? comment;
  final String userName;
  final String? userAvatar;

  Review({
    required this.rating,
    this.comment,
    required this.userName,
    this.userAvatar,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      comment: json['ulasan'], 
      userName: json['user']?['name'] ?? 'Anonim',
      userAvatar: json['user']?['image'],
    );
  }
}