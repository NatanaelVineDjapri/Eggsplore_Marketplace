import 'package:flutter/material.dart';
import 'package:eggsplore/pages/provider/cart_provider.dart';

void showRemoveShopConfirmationDialog({
  required BuildContext context,
  required String shopName,
  required CartNotifier cartNotifier,
  required Color primaryColor,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("Hapus Semua Barang"),
      content: Text(
        "Apakah kamu yakin ingin menghapus semua barang dari toko '$shopName'?",
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Batal", style: TextStyle(color: Colors.grey)),
          onPressed: () => Navigator.of(ctx).pop(),
        ),
        TextButton(
          child: Text("Hapus", style: TextStyle(color: primaryColor)),
          onPressed: () {
            cartNotifier.removeAllItemsByShop(shopName);
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}
