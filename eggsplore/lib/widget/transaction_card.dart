import 'package:flutter/material.dart';
import 'package:eggsplore/model/transaction.dart';


class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({Key? key, required this.transaction}) : super(key: key);

  Color getStatusColor(String status) {
    switch (status) {
      case "Completed": return Colors.green;
      case "Pending": return Colors.orange;
      case "Failed": return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(transaction.id, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text("Date: ${transaction.date}"),
            Text("Amount: \$${transaction.amount.toStringAsFixed(2)}"),
            Text(
              "Status: ${transaction.status}",
              style: TextStyle(color: getStatusColor(transaction.status)),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
