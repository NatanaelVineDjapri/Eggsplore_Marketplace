import 'package:eggsplore/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/pages/provider/cart_provider.dart';

class AddToCartButton extends ConsumerWidget {
  final int productId;
  final String productName;

  const AddToCartButton({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const addIconSize = Appsized.iconLg;
    final addContainerDimension = addIconSize + 12.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(Appsized(context).sm),
      child: Material(
        color: Colors.orange,
        child: InkWell(
          onTap: () async {
            try {
              await ref.read(cartProvider.notifier).addItem(productId, 1);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$productName ditambahkan ke keranjang")),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Gagal menambah ke keranjang: $e")),
              );
            }
          },
          child: SizedBox(
            width: addContainerDimension,
            height: addContainerDimension,
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: addIconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}