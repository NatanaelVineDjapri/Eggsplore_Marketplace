import 'package:flutter/material.dart';

class BuyNowButton extends StatelessWidget {
  final Color color;

  const BuyNowButton({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ElevatedButton(
        onPressed: () {
          // Logika beli langsung
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: const Text("Beli Langsung", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}