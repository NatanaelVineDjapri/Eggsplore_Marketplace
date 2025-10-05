import 'package:flutter/material.dart';

class ProductStock extends StatelessWidget {
  final int stock;

  const ProductStock({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.inventory_2_outlined, size: 18, color: Colors.black87),
        const SizedBox(width: 4),
        Text("stok : $stock"),
      ],
    );
  }
}
