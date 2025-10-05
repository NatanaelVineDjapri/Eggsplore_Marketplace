class Transaction {
  final String id;
  final String date;
  final double amount;
  final String status;
  final String productName;
  final String imageUrl;
  final int quantity;

  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.status,
    required this.productName,
    required this.imageUrl,
    required this.quantity,
  });
}