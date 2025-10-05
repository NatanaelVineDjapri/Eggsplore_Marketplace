import 'package:flutter/material.dart';
import 'package:eggsplore/widget/formatter.dart';

class TopUpItem extends StatelessWidget {
  final double amount;
  final ValueChanged<double> onTap;
  final String imagePath;
  final double width;

  const TopUpItem({
    super.key,
    required this.amount,
    required this.onTap,
    this.imagePath = 'assets/images/money.png',
    this.width = 140,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(amount),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              width: width * 0.45,
              height: width * 0.45,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              formatRupiah(amount),
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
