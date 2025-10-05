import 'dart:convert';
import 'package:eggsplore/model/shop.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ShopService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // 🔹 Ambil semua shop (tanpa auth)
  static Future<List<Shop>> fetchShops() async {
    final response = await http.get(Uri.parse("$baseUrl/shops"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Shop.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load shops: ${response.statusCode}");
    }
  }

  // 🔹 Ambil detail shop (tanpa auth)
  static Future<Shop> fetchShopDetail(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/shops/$id"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Shop.fromJson(data);
    } else {
      throw Exception("Shop not found");
    }
  }

  // 🔹 Ambil detail shop (dengan auth/token)
  static Future<Shop?> getShopDetails(int shopId) async {
    final token = await UserService.getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/shops/$shopId');
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      debugPrint("GET SHOP DETAILS => ${response.statusCode}: ${response.body}");

      if (response.statusCode == 200) {
        return Shop.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      debugPrint("Error fetching shop details: $e");
      return null;
    }
  }

  // 🔹 Update data shop (dengan auth/token)
  static Future<bool> updateShop(int shopId, Map<String, dynamic> data) async {
    final token = await UserService.getToken();
    if (token == null) return false;

    final url = Uri.parse('$baseUrl/shops/$shopId');
    try {
      final response = await http.put(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      debugPrint("UPDATE SHOP => ${response.statusCode}: ${response.body}");
      return response.statusCode == 200;
    } catch (e) {
      debugPrint("Error updating shop: $e");
      return false;
    }
  }
}
