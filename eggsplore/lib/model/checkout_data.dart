// lib/model/checkout_data.dart

import 'user.dart';
import 'cart_item.dart';

class CheckoutData {
  final User user;
  final List<CartItem> cartItems;
  final double itemsSubtotal;
  final double shippingFee;
  final double serviceFee;
  final double grandTotal;

  CheckoutData({
    required this.user,
    required this.cartItems,
    required this.itemsSubtotal,
    required this.shippingFee,
    required this.serviceFee,
    required this.grandTotal,
  });

  factory CheckoutData.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>;
    final cartListJson = json['cart_items'] as List<dynamic>;
    final summaryJson = json['summary'] as Map<String, dynamic>; 

    return CheckoutData(
      user: User.fromJson(userJson),
      cartItems: cartListJson.map((item) => CartItem.fromJson(item as Map<String, dynamic>)).toList(),
      
      // Ambil dari key 'summary' (sesuai asumsi kita)
      itemsSubtotal: (summaryJson['items_subtotal'] as num?)?.toDouble() ?? 0.0,
      shippingFee: (summaryJson['shipping_fee'] as num?)?.toDouble() ?? 0.0,
      serviceFee: (summaryJson['service_fee'] as num?)?.toDouble() ?? 1000.0, 
      grandTotal: (summaryJson['total_amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}