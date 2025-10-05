import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eggsplore/model/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  Map<String, dynamic> _getStatusStyle() {
    switch (transaction.status) {
      case TransactionStatus.paid:
      case TransactionStatus.completed:
        return {'color': Colors.green.shade100, 'textColor': Colors.green.shade800, 'text': 'Berhasil'};
      case TransactionStatus.pending:
        return {'color': Colors.amber.shade100, 'textColor': Colors.amber.shade800, 'text': 'Menunggu Pembayaran'};
      case TransactionStatus.canceled:
        return {'color': Colors.red.shade100, 'textColor': Colors.red.shade800, 'text': 'Dibatalkan'};
      default:
        return {'color': Colors.grey.shade200, 'textColor': Colors.grey.shade800, 'text': 'Tidak Diketahui'};
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusStyle = _getStatusStyle();
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.shopName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusStyle['color'],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusStyle['text'],
                    style: TextStyle(
                      color: statusStyle['textColor'],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: transaction.productImageUrl.startsWith('assets/') 
                    ? Image.asset(
                        transaction.productImageUrl,
                        width: 70, height: 70, fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                          Container(width: 70, height: 70, color: Colors.grey.shade200, child: const Icon(Icons.image_not_supported)),
                      )
                    : transaction.productImageUrl.isNotEmpty
                      ? Image.network(
                          transaction.productImageUrl,
                          width: 70, height: 70, fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                            Container(width: 70, height: 70, color: Colors.grey.shade200, child: const Icon(Icons.image_not_supported)),
                        )
                      : Container(width: 70, height: 70, color: Colors.grey.shade200, child: const Icon(Icons.image)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.productName,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${transaction.quantity} barang',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Belanja',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                Text(
                  formatter.format(transaction.totalPrice),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}