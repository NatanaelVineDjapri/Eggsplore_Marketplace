class OrderItem {
  final int id;
  final int orderId;
  final int? productId;
  final String productName;
  final String shopName;
  final double priceAtPurchase;
  final int quantity;

  OrderItem({
    required this.id,
    required this.orderId,
    this.productId,
    required this.productName,
    required this.shopName,
    required this.priceAtPurchase,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      shopName: json['shop_name'],
      priceAtPurchase: double.parse(json['price_at_purchase'].toString()),
      quantity: json['quantity'],
    );
  }
}