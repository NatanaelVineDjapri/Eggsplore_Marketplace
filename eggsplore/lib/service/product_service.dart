import 'dart:convert';
import 'package:eggsplore/model/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

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


}
