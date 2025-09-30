import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/widget/eggsplore_header.dart';
import 'package:eggsplore/widget/eggsplore_pay/balance_display.dart';
import 'package:eggsplore/widget/topup_item.dart';

class EggsplorePayPage extends StatefulWidget {
  final double balance;
  const EggsplorePayPage({super.key, required this.balance});

  @override
  State<EggsplorePayPage> createState() => _EggsplorePayPageState();
}

class _EggsplorePayPageState extends State<EggsplorePayPage> {
  late double balance;

  @override
  void initState() {
    super.initState();
    balance = widget.balance;
  }

  void addBalance(double amount) => setState(() => balance += amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar(
        title: "Eggsplore Pay",
        onBack: () => Navigator.pop(context, balance),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header (reuse widget)
            const EggsploreHeader(),

            // Balance display (reuse widget)
            BalanceDisplay(balance: balance, imageSize: 80),

            // orange separator
            Container(height: 8, color: Colors.orange),

            // Top Up title
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Top Up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),

            // grid/wrap of topup items using TopUpItem widget
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  TopUpItem(amount: 10000, onTap: (a) => addBalance(a)),
                  TopUpItem(amount: 30000, onTap: (a) => addBalance(a)),
                  TopUpItem(amount: 50000, onTap: (a) => addBalance(a)),
                  TopUpItem(amount: 70000, onTap: (a) => addBalance(a)),
                  TopUpItem(amount: 100000, onTap: (a) => addBalance(a)),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
