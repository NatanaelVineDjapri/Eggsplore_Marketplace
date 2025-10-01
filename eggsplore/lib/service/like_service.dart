import 'dart:convert';
import 'package:eggsplore/model/like_model.dart';
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

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Like.fromJson(data, productId);
    } else {
      throw Exception('Failed to toggle like');
    }
  }
}
