import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToCartButtonProduct extends ConsumerWidget {
  final Product product;
  final Color color;

  const AddToCartButtonProduct({
    super.key,
    required this.product,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 2,
      child: OutlinedButton(
        onPressed: () async {
          try {
            await ref.read(cartProvider.notifier).addItem(product.id, 1);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${product.name} ditambahkan ke keranjang"),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Gagal: $e")));
          }
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: BorderSide(color: color),
        ),
        child: Text(
          "+ Keranjang",
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
}
