import 'package:eggsplore/pages/chat_account_page.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/constants/colors.dart';

class ChatItem extends StatelessWidget {
  final int userId;
  final String name;
  final String username;
  final String date;

  const ChatItem({
    super.key,
    required this.userId,
    required this.name,
    required this.username,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailPage(
              userId: userId,
              username: name,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.grey,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        username,
                        style: const TextStyle(color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(color: AppColors.grey),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
