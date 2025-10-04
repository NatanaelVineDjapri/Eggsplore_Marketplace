class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final double balance;
  final String? image;
  final String? phoneNumber;
  final String? address;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.balance,
    this.image,
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
      image: json['image'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? role,
    double? balance,
    String? image,
    String? phoneNumber,
    String? address,
    String? createdAt,
    String? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      balance: balance ?? this.balance,
      image: image ?? this.image,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
