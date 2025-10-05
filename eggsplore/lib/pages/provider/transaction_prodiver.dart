import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/transaction.dart';

final transactionProvider = Provider<List<Transaction>>((ref) {
  return [
    Transaction(
      orderId: 'INV/2025/10/05/001',
      shopName: 'Toko Jaya',
      productName: 'Figure Ironman 1/144 Size',
      productImageUrl: 'assets/images/ironman.png',
      quantity: 2,
      totalPrice: 52000,
      status: TransactionStatus.completed,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      orderId: 'INV/2025/10/04/002',
      shopName: 'Toko Bu Siti',
      productName: 'Kacamata Keren dan Baru',
      productImageUrl: 'assets/images/kacamata.png',
      quantity: 1,
      totalPrice: 30000,
      status: TransactionStatus.paid,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];
});