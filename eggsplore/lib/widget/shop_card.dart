import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  final String name;
  final String location;

  const ShopCard({super.key, required this.name, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.red, // nanti bisa ganti pakai gambar
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1, // 🔹 Batasi 1 baris
                  overflow: TextOverflow.ellipsis, // 🔹 Tambah titik "..."
                ),
                Text(
                  location,
                  maxLines: 1, // 🔹 Batasi 1 baris
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text("explore shop"),
          ),
        ],
      ),
    );
  }
}
