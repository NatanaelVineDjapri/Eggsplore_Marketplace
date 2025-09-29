import 'package:flutter/material.dart';
import 'package:eggsplore/widget/formatter.dart';

class BalanceDisplay extends StatelessWidget {
  final double balance;
  final String imagePath;
  final double imageSize;

  const BalanceDisplay({
    super.key,
    required this.balance,
    this.imagePath = 'assets/images/money.png',
    this.imageSize = 70, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Jumlah Saldo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),
          Row(
            children: [
              Image.asset(imagePath, width: imageSize, height: imageSize, fit: BoxFit.contain),
              const SizedBox(width: 12),
              Text(
                formatRupiah(balance),
                style: const TextStyle(
                    color: Colors.orange, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
