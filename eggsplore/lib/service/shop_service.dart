import 'dart:convert';
import 'package:eggsplore/model/shop.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShopService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // Fungsi untuk mengambil detail toko berdasarkan ID-nya
  static Future<Shop?> getShopDetails(int shopId) async {
    final token = await UserService.getToken();
    // Pengecekan token diletakkan di awal agar lebih aman
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

  // Fungsi untuk mengirim pembaruan data toko
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
          "Content-Type": "application/json", // Penting untuk request PUT/POST
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