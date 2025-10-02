import 'package:flutter/material.dart';
import '../constants/sizes.dart';
import '../constants/colors.dart';
import 'formatter.dart';

class TopUpItem extends StatelessWidget {
  final double amount;
  final ValueChanged<double> onTap;
  final String imagePath;

  const TopUpItem({
    super.key,
    required this.amount,
    required this.onTap,
    this.imagePath = 'assets/images/money.png',
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.38;

    return GestureDetector(
      onTap: () => onTap(amount),
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: cardWidth * 0.5,
              height: cardWidth * 0.5,
              decoration: const BoxDecoration(
                color: AppColors.iconBg,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              formatRupiah(amount),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: Appsized.fontSm,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
