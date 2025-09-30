import 'dart:convert';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // --- Ambil semua produk ---
  static Future<List<Product>> fetchProducts(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/products"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print("Status code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Gagal load produk: ${response.statusCode}");
    }
  }

  // --- Ambil produk random dari endpoint Laravel ---
  static Future<List<Product>> fetchRandomProducts(String token, {int count = 6}) async {
    final response = await http.get(
      Uri.parse("$baseUrl/products/random?count=$count"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print("Status code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Gagal load produk random: ${response.statusCode}");
    }
  }

  // --- Helper: ambil produk random untuk user saat ini tanpa repot urus token ---
  static Future<List<Product>> fetchRandomProductsForCurrentUser({int count = 6}) async {
    final token = await UserService.getToken(); 
    if (token != null) {
      return fetchRandomProducts(token, count: count);
    }
    return [];
  }

}
