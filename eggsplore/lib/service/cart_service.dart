import 'dart:convert';
import 'package:eggsplore/model/cart_item.dart';
import 'package:http/http.dart' as http;
import 'user_service.dart';

class CartService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static Future<List<CartItem>> fetchCart() async {
    final token = await UserService.getToken();
    if (token == null) throw Exception('User not logged in');

    final response = await http.get(
      Uri.parse('$baseUrl/cart'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print("📥 FETCH CART => ${response.statusCode} : ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List items = data['items'] ?? [];
      return items.map((item) => CartItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load cart (${response.statusCode})');
    }
  }

  static Future<CartItem> addCartItem(int productId, int quantity) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception('User not logged in');

    final response = await http.post(
      Uri.parse('$baseUrl/cart'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json', // tambahin biar jelas
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'product_id': productId,
        'quantity': quantity,
      }),
    );

    print("📤 ADD CART => ${response.statusCode} : ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      return CartItem.fromJson(data['item']);
    } else {
      throw Exception('Failed to add cart item (${response.statusCode})');
    }
  }

  static Future<void> updateCartItem(int itemId, int quantity) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception('User not logged in');

    final response = await http.put(
      Uri.parse('$baseUrl/cart/$itemId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'quantity': quantity}),
    );

    print("✏️ UPDATE CART => ${response.statusCode} : ${response.body}");

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart item (${response.statusCode})');
    }
  }

  static Future<void> removeCartItem(int itemId) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception('User not logged in');

    final response = await http.delete(
      Uri.parse('$baseUrl/cart/$itemId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print("🗑 REMOVE CART => ${response.statusCode} : ${response.body}");

    if (response.statusCode != 200) {
      throw Exception('Failed to remove cart item (${response.statusCode})');
    }
  }
}
