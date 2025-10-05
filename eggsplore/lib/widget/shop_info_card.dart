import 'package:eggsplore/helper/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/constants/text_style.dart';

class ShopInfoCard extends StatelessWidget {
  final String shopName;
  final String description;
  final String followers;
  final String buyers;
  final String rating;
  final String imagePath;
  final VoidCallback onModify;

  const ShopInfoCard({
    super.key,
    required this.shopName,
    required this.description,
    required this.followers,
    required this.buyers,
    required this.rating,
    required this.imagePath,
    required this.onModify,
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
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: imagePath.isNotEmpty ? NetworkImage(imagePath) : null,
            backgroundColor: Colors.grey[200],
            child: imagePath.isEmpty
                ? Icon(Icons.storefront, size: 40, color: Colors.grey[400])
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shopName, style: AppTextStyle.shopTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(description, style: AppTextStyle.description.copyWith(color: Colors.black54), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStat('Followers', followers),
                    _buildStat('Buyers', buyers),
                    _buildStat('Rating', rating, icon: Icons.star, iconColor: Colors.amber),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onModify,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.edit_note, color: Colors.grey, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, {IconData? icon, Color? iconColor}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          if (icon != null) Icon(icon, size: 16, color: iconColor),
          if (icon != null) const SizedBox(width: 4),
          Text(value, style: AppTextStyle.shopStatsValue),
        ]),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyle.shopStatsLabel),
      ],
    );
  }
}