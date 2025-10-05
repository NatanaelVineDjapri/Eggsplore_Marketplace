// lib/service/order_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/order.dart';
import '../service/user_service.dart';

class OrderService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  Future<List<Order>> getOrderHistory() async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("Token otorisasi tidak ditemukan.");

    final response = await http.get(
      Uri.parse("$baseUrl/orders"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final List<dynamic> ordersJson = responseData['data'] ?? [];

      return ordersJson.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception("Gagal memuat riwayat pesanan: ${response.statusCode}");
    }
  }

  Future<Order> getOrderDetail(int orderId) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("Token otorisasi tidak ditemukan.");

    final response = await http.get(
      Uri.parse("$baseUrl/orders/$orderId"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Order.fromJson(responseData['data']);
    } else {
      throw Exception("Gagal memuat detail pesanan: ${response.statusCode}");
    }
  }

  Future<bool> submitRating({
    required int orderItemId,
    required int productId,
    required int ratingValue,
    String? ulasan,
  }) async {
    final token = await UserService.getToken();
    if (token == null) return false;

    final body = {
      'order_item_id': orderItemId,
      'product_id': productId,
      'rating': ratingValue,
      'ulasan': ulasan,
    };

    final response = await http.post(
      Uri.parse("$baseUrl/review/submit"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    return response.statusCode == 201;
  }
}
