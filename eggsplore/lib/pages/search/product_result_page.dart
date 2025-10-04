import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/widget/product.dart';
import 'package:eggsplore/provider/product_provider.dart'; 

class ProductResultPage extends ConsumerWidget {
  final String query;

  const ProductResultPage({super.key, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProducts = ref.watch(randomProductsProvider);

    return asyncProducts.when(
      data: (products) {
        final filtered = query.isEmpty
            ? products
            : products
                .where((p) =>
                    p.name.toLowerCase().contains(query.toLowerCase()) ||
                    p.description.toLowerCase().contains(query.toLowerCase()))
                .toList();

        if (filtered.isEmpty) {
          return const Center(
            child: Text("Produk tidak ditemukan"),
          );
        }

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
            return ProductCard(
              productId: p.id,
              name: p.name,
              price: p.price,
              image: p.image,
              isLiked: false,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text("Error: $e")),
    );
  }
}
