import 'package:flutter/material.dart';
import 'package:eggsplore/widget/formatter.dart';
import 'package:eggsplore/constants/colors.dart';

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
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.iconBg,
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
          Text(
            formatRupiah(balance),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
