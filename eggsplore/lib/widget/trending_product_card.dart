import 'package:flutter/material.dart';

class TrendingProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String? image; 
  const TrendingProductCard({
    super.key,
    required this.name,
    required this.price,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
  child: image != null
      ? ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: Image.asset(
            image!,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        )
      : Container(
          color: Colors.grey[300],
          child: const Icon(Icons.image, size: 50, color: Colors.grey),
        ),
),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(price,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_circle, color: Colors.orange),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
