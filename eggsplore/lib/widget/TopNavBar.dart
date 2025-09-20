import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget {
  final VoidCallback onChatTap;
  final ValueChanged<String>? onSearch;

  const TopNavBar({super.key, required this.onChatTap, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 1, left: 16, right: 16, bottom: 12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                onChanged: onSearch,
                decoration: const InputDecoration(
                  hintText: "Search Product",
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onChatTap,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
