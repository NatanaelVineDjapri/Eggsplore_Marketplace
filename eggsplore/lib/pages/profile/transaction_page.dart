import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFAE11),
      appBar: backBar(title: "Transaction"),
      body: const Center(
        child: Text(
          "Transactions will appear here (backend integration coming soon).",
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
