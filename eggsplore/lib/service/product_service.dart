import 'dart:convert';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/model/review.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  static Future<List<Product>> fetchProducts(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/products"),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
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

  static Future<List<Product>> fetchRandomProducts(
    String token, {
    int count = 6,
  }) async {
    final response = await http.get(
      Uri.parse("$baseUrl/products/random?count=$count"),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
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

  static Future<List<Product>> fetchRandomProductsForCurrentUser({
    int count = 6,
  }) async {
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
    headers: {
      "Authorization": "Bearer $token",
      "Accept": "application/json",
    },
  );

  print("Trending Status: ${response.statusCode}");
  print("Trending Body: ${response.body}");

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    // fleksibel: bisa {"data": [...]} atau langsung [...]
    final List<dynamic> products =
    (data is List)
        ? data
        : (data['data'] ?? data['products'] ?? []);


    print("🔥 Parsed Products: $products");

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

  static Future<bool> rateProduct(
    int productId,
    int rating, {
    String? comment,
  }) async {
    final token = await UserService.getToken();
    if (token == null) return false;

    final response = await http.post(
      Uri.parse('$baseUrl/products/$productId/rate'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"rating": rating, "comment": comment ?? ""}),
    );

    return response.statusCode == 200;
  }

  static Future<Product> fetchProductDetail(int productId) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("User belum login / token kosong");

    final url = Uri.parse('$baseUrl/products/$productId');
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    print("Detail Product Status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final productJson = data['product'] as Map<String, dynamic>;

      productJson['average_rating'] = data['average_rating'] ?? 0.0;

      return Product.fromJson(productJson);
    } else {
      throw Exception("Gagal load detail produk: ${response.statusCode}");
    }
  }

  static Future<List<Product>> fetchProductsFromShop({
  required int shopId,
  int? excludeProductId,
}) async {
  final token = await UserService.getToken();
  if (token == null) {
    throw Exception("User belum login / token kosong");
  }

  var uri = Uri.parse('$baseUrl/shops/$shopId/products');
  if (excludeProductId != null) {
    uri = uri.replace(
      queryParameters: {'exclude': excludeProductId.toString()},
    );
  }

  print("🕵‍♂ MEMULAI PANGGILAN API ke: $uri");

  try {
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    ).timeout(const Duration(seconds: 15)); // Tambahkan timeout 15 detik

    print("✅ API MERESPON dengan status: ${response.statusCode}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> productList = data['data'];
      print("✅ BERHASIL PARSING DATA");
      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      print("❌ GAGAL: ${response.body}");
      throw Exception("Gagal memuat produk toko: ${response.statusCode}");
    }
  } catch (e) {
    print("❌ TERJADI ERROR: ${e.toString()}");
    // Jika errornya 'TimeoutException', berarti server benar-benar tidak menjawab.
    throw Exception("Gagal menghubungi server: ${e.toString()}");
  }
}

  static Future<List<Review>> fetchReviews(int productId) async {
    final token = await UserService.getToken();
    if (token == null) {
      throw Exception("User belum login / token kosong");
    }
    final response = await http.get(
      Uri.parse('$baseUrl/products/$productId/reviews'),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      }, // Asumsi pakai helper otentikasi
    );

    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> reviewList = data['data'];
      return reviewList.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception("Gagal memuat ulasan produk");
    }
  }
}