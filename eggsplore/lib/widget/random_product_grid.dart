import 'package:eggsplore/widget/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pages/provider/product_provider.dart'; 
import '../pages/provider/like_provider.dart';

class RandomProductsGrid extends ConsumerWidget {
  const RandomProductsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomProductsAsync = ref.watch(randomProductsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Produk Lainnya Untukmu",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        randomProductsAsync.when(
          data: (products) {
            if (products.isEmpty) {
              return const Center(
                child: Text(
                  "Tidak ada produk rekomendasi.",
                  style: TextStyle(color: Colors.grey)
                ),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0, 
                mainAxisSpacing: 16.0,  
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                final isLiked = ref.watch(likeStateProvider)[product.id]?.userLiked ?? false;

                return ProductCard(
                  productId: product.id,
                  name: product.name,
                  price: product.price,
                  image: product.image,
                  isLiked: isLiked,
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: $err")),
        ),
      ],
    );
  }
}