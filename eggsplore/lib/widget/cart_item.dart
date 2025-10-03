import 'package:flutter/material.dart';
import 'package:eggsplore/model/cart_item.dart';
import 'package:eggsplore/constants/colors.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: item.image != null
            ? Image.network(
                item.image!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image_not_supported, size: 40),
        title: Text(item.name ?? "Produk tidak ditemukan"),
        subtitle: Text("Rp ${(item.price * item.quantity).toStringAsFixed(0)}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (item.quantity > 1) onQuantityChanged(item.quantity - 1);
              },
            ),
            Text(item.quantity.toString()),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onQuantityChanged(item.quantity + 1),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: AppColors.redd),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
