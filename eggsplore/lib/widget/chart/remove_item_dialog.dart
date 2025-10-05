import 'package:flutter/material.dart';
import 'package:eggsplore/model/cart_item.dart';
import 'package:eggsplore/pages/provider/cart_provider.dart';

void showRemoveItemConfirmationDialog({
  required BuildContext context,
  required CartItem item,
  required CartNotifier cartNotifier,
  required Color primaryColor,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("Hapus Barang"),
      content: Text(
        "Apakah kamu yakin ingin menghapus '${item.name}' dari keranjang?",
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Batal", style: TextStyle(color: Colors.grey)),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
        TextButton(
          child: Text("Hapus", style: TextStyle(color: primaryColor)),
          onPressed: () {
            cartNotifier.removeItem(item.id);
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}
