import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eggsplore/model/shop.dart';

class ShopService {
  static const String baseUrl = "http://10.0.2.2:8000/api"; // ganti sesuai domain/api lo

  static Future<List<Shop>> fetchShops() async {
    final response = await http.get(Uri.parse("$baseUrl/shops"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Shop.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load shops: ${response.statusCode}");
    }
  }

  static Future<Shop> fetchShopDetail(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/shops/$id"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Shop.fromJson(data);
    } else {
      throw Exception("Shop not found");
    }
  }
}
