import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eggsplore/model/order.dart';

class CartItemToSend {
  final int productId;
  final int quantity;
  CartItemToSend({required this.productId, required this.quantity});
}

class CheckoutService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  Future<Order> createOrder({
    required String token,
    required String shippingAddress,
    required String receiverName,
    required String receiverPhone,
    required List<CartItemToSend> items,
  }) async {
    final url = Uri.parse('$baseUrl/orders');

    final body = json.encode({
      'shipping_address': shippingAddress,
      'receiver_name': receiverName,
      'receiver_phone': receiverPhone,
      'items': items
          .map(
            (item) => {'product_id': item.productId, 'quantity': item.quantity},
          )
          .toList(),
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );

    print("CHECKOUT STATUS: ${response.statusCode}");
    print("CHECKOUT BODY: ${response.body}");

    final responseBody = json.decode(response.body);

    if (response.statusCode == 201) {
      return Order.fromJson(responseBody['order']);
    } else {
      final errorMessage =
          responseBody['message'] ?? 'Terjadi kesalahan tidak diketahui.';
      throw Exception(errorMessage);
    }
  }
}
