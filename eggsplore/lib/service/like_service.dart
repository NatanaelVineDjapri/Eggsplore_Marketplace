import 'dart:convert';
import 'package:eggsplore/model/like_model.dart';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:http/http.dart' as http;

class LikeService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  Future<Like?> toggleLike(int productId, String token) async {
    final url = Uri.parse('$baseUrl/products/$productId/like');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print("TOGGLE LIKE STATUS: ${response.statusCode}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Like.fromJson(data, productId);
    }

    if (response.statusCode == 401 || response.statusCode == 403) {
      throw Exception('Authentication Failed (401/403). Please log in again.');
    }

    throw Exception('Server Error (${response.statusCode}): ${response.body}');
  }

  Future<List<Product>> fetchLikedProducts() async {
    final token = await UserService.getToken();
    if (token == null) throw Exception('User not logged in');

    final url = Uri.parse('$baseUrl/user/liked-products');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch liked products');
    }
  }
}
