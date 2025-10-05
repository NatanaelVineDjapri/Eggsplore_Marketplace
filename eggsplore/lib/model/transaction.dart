enum TransactionStatus { pending, paid, completed, canceled, unknown }

class Transaction {
  final String orderId;
  final String shopName;
  final String productName;
  final String productImageUrl;
  final int quantity;
  final double totalPrice;
  final TransactionStatus status;
  final DateTime date;

  Transaction({
    required this.orderId,
    required this.shopName,
    required this.productName,
    required this.productImageUrl,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.date,
  });
}