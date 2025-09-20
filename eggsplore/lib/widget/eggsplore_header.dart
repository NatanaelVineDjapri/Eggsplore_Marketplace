// lib/widget/eggsplore_header.dart
import 'package:flutter/material.dart';

class EggsploreHeader extends StatelessWidget {
  final String username;
  final double avatarRadius; // bisa diset lebih besar kalau mau
  const EggsploreHeader({
    super.key,
    this.username = 'USERNAME',
    this.avatarRadius = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: avatarRadius, color: Colors.orange),
          ),
          const SizedBox(width: 12),
          Text(
            username,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
