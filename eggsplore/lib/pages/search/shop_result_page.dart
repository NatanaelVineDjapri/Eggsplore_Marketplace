import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/provider/shop_provider.dart';
import 'package:eggsplore/widget/shop_card.dart';

class ShopResultPage extends ConsumerWidget {
  final String query;

  const ShopResultPage({super.key, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopsAsync = ref.watch(shopsProvider);

    return shopsAsync.when(
      data: (shops) {
        final filtered = query.isEmpty
            ? shops
            : shops
                  .where(
                    (s) => s.name.toLowerCase().contains(query.toLowerCase()),
                  )
                  .toList();

        if (filtered.isEmpty) {
          return const Center(child: Text("Tidak ada toko ditemukan"));
        }

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final shop = filtered[index];
            return ShopCard(shop: shop);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Error: $err")),
    );
  }
}
