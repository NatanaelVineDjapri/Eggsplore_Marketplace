import 'package:flutter/material.dart';
import 'package:eggsplore/widget/transaction_card.dart';
import 'package:eggsplore/model/transaction.dart';


  class TransactionPage extends StatelessWidget {
    final List<Transaction> transactions = [
    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Transaction History"),
        ),
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
