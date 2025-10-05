import 'dart:convert';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/model/shop.dart';
import 'package:eggsplore/model/shop_with_products.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ShopService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  static Future<Shop?> getMyShop() async {
    final token = await UserService.getToken();
    if (token == null) {
      debugPrint("Token not found");
      return null;
    }

    final url = Uri.parse('$baseUrl/user/shop');
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );
      debugPrint("GET MY SHOP => ${response.statusCode} : ${response.body}");
      if (response.statusCode == 200) {
        return Shop.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      debugPrint("Error fetching my shop: $e");
      return null;
    }
  }

  static Future<bool> updateShop(
    int shopId,
    Map<String, dynamic> shopData,
  ) async {
    final token = await UserService.getToken();
    if (token == null) {
      debugPrint("Token not found");
      return false;
    }

    final url = Uri.parse('$baseUrl/shops/$shopId');
    try {
      final response = await http.put(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(shopData),
      );

      debugPrint("UPDATE SHOP => ${response.statusCode} : ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      debugPrint("Error updating shop: $e");
      return false;
    }
  }

   Future<ShopWithProducts> getShopById(int shopId) async {
    final token = await UserService.getToken();
    final url = Uri.parse('$baseUrl/shops/$shopId');
    try {
      final response = await http.get(
        url,
        headers: {
           "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Accept": "application/json",
        },
      );

      debugPrint("GET SHOP BY ID => ${response.statusCode} : ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return ShopWithProducts.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat data toko: Status code ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error fetching shop by id: $e");
      throw Exception('Terjadi kesalahan saat mengambil data toko.');
    }
  }
}
