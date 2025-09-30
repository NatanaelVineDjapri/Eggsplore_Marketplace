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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Jumlah Saldo",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon di lingkaran
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  imagePath,
                  width: imageSize * 0.7,
                  height: imageSize * 0.7,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 16),
              // Text balance
              Text(
                formatRupiah(balance),
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
