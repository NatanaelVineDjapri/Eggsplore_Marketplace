import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/cart_item.dart';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/pages/checkout_page.dart';

class BuyNowButton extends ConsumerWidget {
  final Color color;
  final Product product;

  const BuyNowButton({
    super.key,
    required this.color,
    required this.product,
  });

  void _showQuantityDialog(BuildContext context, WidgetRef ref) {
    if (product.stock == 0) return;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        int quantity = 1;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Pilih Kuantitas"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: quantity > 1
                        ? () => setState(() => quantity--)
                        : null,
                  ),
                  Text(quantity.toString(),
                      style: const TextStyle(fontSize: 20)),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.green),
                    onPressed: quantity < product.stock
                        ? () => setState(() => quantity++)
                        : null,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text("Batal"),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
                ElevatedButton(
                  child: const Text("Lanjut Checkout"),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    _handleBuyNow(context, ref, quantity);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
  
  void _handleBuyNow(
    BuildContext context,
    WidgetRef ref,
    int quantity,
  ) {
    final itemToCheckout = CartItem(
      id: 0,
      productId: product.id,
      name: product.name,
      price: product.price,
      quantity: quantity,
      shopName: product.shopName,
      image: product.image,
    );

    final List<CartItem> items = [itemToCheckout];

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutPage(
            itemsToCheckout: items,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOutOfStock = product.stock == 0;
    return Expanded(
      flex: 3,
      child: ElevatedButton(
        onPressed: isOutOfStock 
            ? null 
            : () => _showQuantityDialog(context, ref),
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutOfStock ? Colors.grey : color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          isOutOfStock ? "Stok Habis" : "Beli Langsung",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}