class ReviewModel {
  final int id;
  final int rating;
  final String? ulasan;
  final String userName;

  ReviewModel({
    required this.id,
    required this.rating,
    this.ulasan,
    required this.userName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as int,
      rating: json['rating'] as int,
      ulasan: json['ulasan'] as String?,
      userName: json['user']?['name'] ?? "Anonim",
    );
  }
}