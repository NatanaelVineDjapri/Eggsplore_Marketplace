import 'dart:convert';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/model/review.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

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
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['data'] ?? data;
      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Gagal ambil produk trending");
    }
  }

    static Future<bool> addProduct({
    required Map<String, dynamic> productData,
    required String imagePath,
  }) async {
    try {
      final token = await UserService.getToken();
      if (token == null) {
        print('Token tidak ditemukan. User belum login.');
        return false;
      }

      // === AMBIL SHOP_ID DULU SEBELUM KIRIM PRODUK ===
      final shopResponse = await http.get(
        Uri.parse("$baseUrl/user/shop"), // ← endpoint ambil shop user
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (shopResponse.statusCode != 200) {
        print("Gagal ambil data toko: ${shopResponse.body}");
        throw Exception("Anda harus membuat toko terlebih dahulu.");
      }

      final shopData = jsonDecode(shopResponse.body);
      final shopId = shopData['id'] ?? shopData['shop_id'];
      if (shopId == null) {
        throw Exception("Shop ID tidak ditemukan dalam respons API.");
      }

      // === BUAT REQUEST TAMBAH PRODUK ===
      final url = Uri.parse('$baseUrl/products');

      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      // Sertakan shop_id dari hasil fetch
      request.fields['shop_id'] = shopId.toString();
      request.fields['name'] = productData['name'] as String;
      request.fields['description'] = productData['description'] as String;
      request.fields['price'] = productData['price'].toString();
      request.fields['stock'] = productData['stock'].toString();

      // Tambahkan gambar
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imagePath,
        filename: imagePath.split('/').last,
      ));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("ADD PRODUCT => ${response.statusCode} : $responseBody");

      if (response.statusCode == 201) {
        return true;
      } else {
        final errorResponse = jsonDecode(responseBody);
        print('Gagal menambahkan produk: ${response.statusCode}');
        print('Error body: $errorResponse');

        if (errorResponse['message'] != null) {
          throw Exception(errorResponse['message']);
        }

        return false;
      }
    } catch (e) {
      print('Terjadi kesalahan saat menambahkan produk: $e');
      return false;
    }
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

    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> productList = data['data'];
      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Gagal memuat produk toko: ${response.statusCode}");
    }
  }

  static Future<String?> getShopId(String token) async {
    final response = await http.get(
      Uri.parse("https://yourapi.com/api/user/shop"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["id"].toString();
    } else {
      print("Gagal ambil shop_id: ${response.body}");
      return null;
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
      },
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