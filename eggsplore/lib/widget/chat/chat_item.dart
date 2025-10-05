import 'package:eggsplore/helper/image_helper.dart';
import 'package:eggsplore/pages/chat_account_page.dart';
import 'package:flutter/material.dart';

import 'package:eggsplore/constants/colors.dart';

class ChatItem extends StatelessWidget {
  final int userId;
  final String name;
  final String username;
  final String? imagePath;

  const ChatItem({
    super.key,
    required this.userId,
    required this.name,
    required this.username,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    // Dapatkan URL absolut
    final String imageUrl = ImageHelper.getImageUrl(imagePath);
    final bool hasImage = imageUrl.isNotEmpty;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatDetailPage(userId: userId, username: name),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: hasImage
                      ? NetworkImage(imageUrl) as ImageProvider
                      : null,
                  child: !hasImage
                      ? Text(
                          name[0].toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
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
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
