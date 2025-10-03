import 'package:flutter/material.dart';
import 'package:eggsplore/constants/colors.dart';

class BannerCard extends StatelessWidget {
  final String imagePath;

  const BannerCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.grey.shade300,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          height: 140,
          width: double.infinity,
        ),
      ),
    );
  }
}
