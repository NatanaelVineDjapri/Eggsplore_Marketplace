class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final double balance;
  final String image; 
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.balance,
    required this.image, 
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    double balanceValue = 0.0;

    if (json['balance'] != null) {
      if (json['balance'] is String) {
        balanceValue = double.tryParse(json['balance']) ?? 0.0;
      } else if (json['balance'] is num) {
        balanceValue = (json['balance'] as num).toDouble();
      }
    }

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      balance: balanceValue,
      image: json['image'] ?? '', // <-- ambil dari JSON, default kosong
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
