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
  static Future<List<Product>> fetchRandomProductsForCurrentUser({int count = 50}) async {
    final token = await UserService.getToken(); 
    if (token != null) {
      return fetchRandomProducts(token, count: count);
    }
    return [];
  }

  static Future<List<Product>> fetchTrendingProducts() async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("User belum login / token kosong");

    final url = Uri.parse('$baseUrl/products/trending');
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token","Content-Type": "application/json",},
    );
    print("test => ${response.statusCode} : ${response.body}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data; // ga perlu data['data']
      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Gagal ambil produk trending");
    }
  }

  static Future<bool> addProduct(Product product) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("User belum login / token kosong");

    final url = Uri.parse('$baseUrl/products');
    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(product.toJson()),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> updateProduct(Product product) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("User belum login / token kosong");

    final url = Uri.parse('$baseUrl/products/${product.id}');
    final response = await http.put(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(product.toJson()),
    );

    return response.statusCode == 200;
  }

  static Future<bool> deleteProduct(int id) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("User belum login / token kosong");

    final url = Uri.parse('$baseUrl/products/$id');
    final response = await http.delete(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode == 200;
  }

  static Future<bool> rateProduct(int productId, int rating, {String? comment}) async {
      final token = await UserService.getToken(); 
      if (token == null) return false;

      final response = await http.post(
        Uri.parse('$baseUrl/products/$productId/rate'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "rating": rating,
          "comment": comment ?? "",
        }),
      );

      return response.statusCode == 200;
  }
}
