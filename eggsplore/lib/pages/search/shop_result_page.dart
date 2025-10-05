import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/provider/shop_provider.dart';
import 'package:eggsplore/widget/shop_card.dart';
import 'package:eggsplore/model/shop.dart';

class ShopResultPage extends ConsumerWidget {
  final String query;

  const ShopResultPage({super.key, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopsAsync = ref.watch(shopsProvider);

    return shopsAsync.when(
      data: (shops) {
        // 🔎 filter toko berdasarkan query
        final List<Shop> filtered = query.isEmpty
            ? shops
            : shops
                .where((s) => s.name.toLowerCase().contains(query.toLowerCase()))
                .toList();

        if (filtered.isEmpty) {
          return const Center(child: Text("Tidak ada toko ditemukan"));
        }

        // 🔹 render pakai ShopCard
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            return ShopCard(shop: filtered[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Error: $err")),
    );
  }
}
