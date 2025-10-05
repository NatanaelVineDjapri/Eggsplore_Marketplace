import 'package:flutter/material.dart';
import 'package:eggsplore/widget/trending_product_card.dart';

class ProductResultPage extends StatelessWidget {
  final String query;

  const ProductResultPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    final products = [
      {"name": "Telur 1kg", "price": "Rp. 25.000"},
      {"name": "Ayam Potong 1 Ekor", "price": "Rp. 40.000"},
      {"name": "Cabai 500gr", "price": "Rp. 30.000"},
      {"name": "ZGMF-X10A Freedom Gundam", "price": "Rp. 1.500.000"},
    ];

    final filtered = query.isEmpty
        ? products
        : products
              .where(
                (p) => p["name"]!.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final p = filtered[index];
        return TrendingProductCard(name: p["name"]!, price: p["price"]!);
      },
    );
  }
}
