import 'package:flutter/material.dart';
import 'package:eggsplore/widget/shop_card.dart';

class ShopResultPage extends StatelessWidget {
  final String query;

  const ShopResultPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    final shops = [
      {"name": "Ayam Kecap", "location": "Tangerang"},
      {"name": "Toko Cabai Segar", "location": "Jakarta"},
      {"name": "Fresh Farm", "location": "Bandung"},
      {"name": "Gundam Store", "location": "Bekasi"},
    ];

    final filtered = query.isEmpty
        ? shops
        : shops.where((s) => s["name"]!.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final shop = filtered[index];
        return ShopCard(
          name: shop["name"]!,
          location: shop["location"]!,
        );
      },
    );
  }
}
