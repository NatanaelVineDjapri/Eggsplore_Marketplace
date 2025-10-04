class Shop {
  final int id;
  final String name;
  final String? description;
  final String? address;
  final String? image;
  final String? profilePicture;
  final User? user;

  Shop({
    required this.id,
    required this.name,
    this.description,
    this.address,
    this.image,
    this.profilePicture,
    this.user,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      image: json['image'],
      profilePicture: json['profile_picture'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
