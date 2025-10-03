import 'package:flutter/material.dart';
import 'package:eggsplore/widget/proiflebar/transaction.dart';
import 'package:eggsplore/model/transaction.dart';

class TransactionPage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: "1",
      date: "30 Sep 2025",
      amount: 999000,
      status: "Completed",
      productName: "testproduk",
      imageUrl: "https://your-image-url.com",
      quantity: 1,
    ),
  ];

  TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transaction History")),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return TransactionCard(transaction: transactions[index]);
        },
      ),
    );
  }
}