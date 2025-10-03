class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final double balance;
  final String image; // Diambil dari versi pertama
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.balance,
    required this.image, // Ditambahkan di sini
    required this.createdAt,
    required this.updatedAt,
  });

  // Method copyWith dari versi kedua, disesuaikan dengan properti 'image'
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? role,
    double? balance,
    String? image, // Ditambahkan di sini
    String? createdAt,
    String? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      balance: balance ?? this.balance,
      image: image ?? this.image, // Ditambahkan di sini
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Factory fromJson dari versi pertama yang sudah menangani 'image'
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
      image: json['image'] ?? '', // Logika dari versi pertama
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Method toJson dari versi kedua, disesuaikan dengan properti 'image'
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'balance': balance,
      'image': image, // Ditambahkan di sini
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}