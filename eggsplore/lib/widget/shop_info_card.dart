import 'package:flutter/material.dart';
import 'package:eggsplore/constants/colors.dart';

class ShopInfoCard extends StatelessWidget {
  final String shopName;
  final String followers;
  final String buyers;
  final String rating;
  final String imagePath;
  final VoidCallback onModify; // callback ke page modify

  const ShopInfoCard({
    super.key,
    required this.shopName,
    required this.followers,
    required this.buyers,
    required this.rating,
    required this.imagePath,
    required this.onModify,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.bleki.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shopName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Text("Followers: $followers"),
                Text("Buyers: $buyers"),
                Text("Rating: $rating"),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primary),
            onPressed: onModify,
            tooltip: "Modify Shop Info",
          ),
        ],
      ),
    );
  }
}
