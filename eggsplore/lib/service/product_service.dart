import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/model/review.dart';
import 'package:eggsplore/service/user_service.dart';

class ProductService {
  static const String _baseUrl = "http://10.0.2.2:8000/api";
  static Future<List<Product>> fetchProducts([String? tokenParam]) async {
    final token = tokenParam ?? await UserService.getToken();
    if (token == null) throw Exception("User belum login / token kosong");

    final url = Uri.parse("$_baseUrl/products");
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      debugPrint("FETCH ALL PRODUCTS => ${response.statusCode}");

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> list =
            (body is List) ? body : (body['data'] as List<dynamic>? ?? []);
        return list
            .map((e) => Product.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else {
        throw Exception("Gagal memuat produk: ${response.body}");
      }
    } on SocketException {
      throw const SocketException(
          "Tidak ada koneksi internet atau server tidak dapat dihubungi.");
    } catch (e) {
      debugPrint("Error di fetchProducts: ${e.toString()}");
      rethrow;
    }
  }

  static Future<List<Product>> fetchRandomProducts(
    String token, {
    int count = 6,
  }) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/products/random?count=$count"),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> list =
          (body is List) ? body : (body['data'] as List<dynamic>? ?? []);
      return list
          .map((e) => Product.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } else {
      throw Exception("Gagal load produk random: ${response.statusCode}");
    }
  }

  static Future<List<Product>> fetchRandomProductsForCurrentUser({
    int count = 6,
  }) async {
    final token = await UserService.getToken();
    if (token == null) return [];

    try {
      return fetchRandomProducts(token, count: count);
    } catch (e) {
      debugPrint("Error di fetchRandomProductsForCurrentUser: $e");
      return [];
    }
  }

  static Future<List<Product>> fetchTrendingProducts() async {
  final token = await UserService.getToken();
  if (token == null) throw Exception("User belum login / token kosong");

  final url = Uri.parse("$_baseUrl/products/trending");
  try {
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    ).timeout(const Duration(seconds: 15));

    debugPrint("FETCH TRENDING => ${response.statusCode} ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> products = data is List ? data : (data['data'] ?? []);
      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil produk trending: ${response.body}");
    }
  } catch (e) {
    debugPrint("Error di fetchTrendingProducts: $e");
    rethrow;
  }
}


  static Future<Product> fetchProductDetail(int productId) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("User belum login / token kosong");

    final url = Uri.parse("$_baseUrl/products/$productId");
    try {
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
      );

      debugPrint("FETCH DETAIL PRODUCT => ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final Map<String, dynamic> productJson = data['product'] != null
            ? Map<String, dynamic>.from(data['product'])
            : Map<String, dynamic>.from(data);

        productJson['average_rating'] =
            data['average_rating'] ?? productJson['average_rating'] ?? 0.0;

        return Product.fromJson(productJson);
      } else {
        throw Exception("Gagal load detail produk: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error di fetchProductDetail: $e");
      rethrow;
    }
  }

  static Future<List<Product>> fetchProductsFromShop({
    required int shopId,
    int? excludeProductId,
  }) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("User belum login / token kosong");

    var uri = Uri.parse("$_baseUrl/shops/$shopId/products");
    if (excludeProductId != null) {
      uri = uri.replace(queryParameters: {'exclude': excludeProductId.toString()});
    }

    try {
      final response = await http
          .get(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Accept": "application/json",
            },
          )
          .timeout(const Duration(seconds: 15));

      debugPrint("FETCH SHOP PRODUCTS => ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> productList = data['data'];
        return productList.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Gagal memuat produk toko: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error di fetchProductsFromShop: $e");
      rethrow;
    }
  }

  static Future<List<Product>> fetchMyProducts([String? tokenParam]) async {
    final token = tokenParam ?? await UserService.getToken();
    if (token == null) throw Exception("User belum login / token kosong");

    final url = Uri.parse("$_baseUrl/my-products");
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    debugPrint("FETCH MY PRODUCTS => ${response.statusCode}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat produk saya: ${response.statusCode}');
    }
  }

  static Future<bool> addProduct({
    required Map<String, dynamic> productData,
    required String imagePath,
  }) async {
    final token = await UserService.getToken();
    if (token == null) {
      debugPrint("Token tidak ditemukan. User belum login.");
      return false;
    }

    try {
      final shopResponse = await http.get(
        Uri.parse("$_baseUrl/user/shop"),
        headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      );

      if (shopResponse.statusCode != 200) {
        throw Exception("Anda harus membuat toko terlebih dahulu.");
      }

      final shopData = jsonDecode(shopResponse.body);
      final shopId = shopData['id'] ?? shopData['shop_id'];
      if (shopId == null) throw Exception("Shop ID tidak ditemukan.");

      var request = http.MultipartRequest('POST', Uri.parse("$_baseUrl/products"));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.fields.addAll({
        'shop_id': shopId.toString(),
        'name': productData['name'].toString(),
        'description': productData['description'].toString(),
        'price': productData['price'].toString(),
        'stock': productData['stock'].toString(),
      });

      request.files.add(await http.MultipartFile.fromPath('image', imagePath));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      debugPrint("ADD PRODUCT => ${response.statusCode} : $responseBody");

      return response.statusCode == 201;
    } catch (e) {
      debugPrint("Error saat menambahkan produk: $e");
      return false;
    }
  }

  static Future<bool> updateProduct(Product product) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("User belum login / token kosong");

    final url = Uri.parse("$_baseUrl/products/${product.id}");
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

  /// Hapus produk
  static Future<bool> deleteProduct(int id) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("User belum login / token kosong");

    final url = Uri.parse("$_baseUrl/products/$id");
    final response = await http.delete(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode == 200;
  }

  /// Beri rating produk
  static Future<bool> rateProduct(
    int productId,
    int rating, {
    String? comment,
  }) async {
    final token = await UserService.getToken();
    if (token == null) return false;

    final response = await http.post(
      Uri.parse("$_baseUrl/products/$productId/rate"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: jsonEncode({"rating": rating, "comment": comment ?? ""}),
    );

    debugPrint("RATE PRODUCT => ${response.statusCode}");
    return response.statusCode == 200;
  }

  static Future<List<Review>> fetchReviews(int productId) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("User belum login / token kosong");

    final url = Uri.parse("$_baseUrl/products/$productId/reviews");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    debugPrint("FETCH REVIEWS => ${response.statusCode}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> reviewList = data['data'];
      return reviewList.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception("Gagal memuat ulasan produk");
    }
  }

  static Future<String?> getShopId(String token) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/user/shop"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["id"].toString();
    } else {
      debugPrint("Gagal ambil shop_id: ${response.body}");
      return null;
    }
  }
}
