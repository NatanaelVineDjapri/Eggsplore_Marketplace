import 'package:flutter/material.dart';
import 'package:eggsplore/constants/colors.dart';

class TopNavBar extends StatelessWidget {
  final VoidCallback onChatTap;
  final ValueChanged<String>? onSearch;

  const TopNavBar({
    super.key,
    required this.onChatTap,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: AppColors.bleki.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onSubmitted: onSearch,
              decoration: const InputDecoration(
                hintText: "Search Product",
                border: InputBorder.none,
                icon: Icon(Icons.search, color: AppColors.grey),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Chat button
        GestureDetector(
          onTap: onChatTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.bleki.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.chat_bubble_outline, color: AppColors.bleki),
          ),
        ),
      ],
    );
  }
}
