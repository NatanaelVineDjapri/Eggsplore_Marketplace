import 'package:flutter/material.dart';

class ProductRating extends StatelessWidget {
  final double averageRating;
  final int totalReviews;

  const ProductRating({
    super.key,
    required this.averageRating,
    required this.totalReviews,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_border, size: 18, color: Colors.black87),
        const SizedBox(width: 4),
        Text("${averageRating.toStringAsFixed(1)} ($totalReviews)"),
      ],
    );
  }
}
