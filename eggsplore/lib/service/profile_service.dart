import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/service/user_service.dart';

class ProfileService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // Ambil detail user yang sedang login
  static Future<User?> getProfile() async {
    final token = await UserService.getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/user"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception("Gagal fetch profile: ${response.body}");
    }
  }

  // Update profile user
  static Future<User?> updateProfile(Map<String, dynamic> body) async {
    final token = await UserService.getToken();

    final response = await http.put(
      Uri.parse("$baseUrl/user"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception("Gagal update profile: ${response.body}");
    }
  }
}
