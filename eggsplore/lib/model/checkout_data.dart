import 'user.dart';
import 'cart_item.dart';

// Helper function untuk mengatasi masalah 'String' is not a subtype of 'num'
double _parseDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

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
      
      itemsSubtotal: _parseDouble(summaryJson['items_subtotal']),
      shippingFee: _parseDouble(summaryJson['shipping_fee']),
      serviceFee: _parseDouble(summaryJson['service_fee']), 
      grandTotal: _parseDouble(summaryJson['total_amount']),
    );
  }
}
