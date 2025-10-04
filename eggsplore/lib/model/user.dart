class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final double balance;
  final String? image; // Menjadi nullable
  final String? phoneNumber; // Properti baru
  final String? address; // Properti baru
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.balance,
    this.image, // Tidak lagi required
    this.phoneNumber,
    this.address,
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
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      balance: balanceValue,
      image: json['image'] as String?, // Mengambil nilai image, bisa null
      phoneNumber: json['phone_number'] as String?, // Mengambil nilai phone_number
      address: json['address'] as String?, // Mengambil nilai address
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}