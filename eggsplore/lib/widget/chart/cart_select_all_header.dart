import 'package:flutter/material.dart';
import 'package:eggsplore/provider/cart_provider.dart';
import 'package:eggsplore/model/cart_item.dart';

class CartSelectAllHeader extends StatelessWidget {
  final CartNotifier cartNotifier;
  final bool allSelected;
  final List<CartItem> selectedItems;
  final Color primaryColor;

  const CartSelectAllHeader({
    super.key,
    required this.cartNotifier,
    required this.allSelected,
    required this.selectedItems,
    required this.primaryColor,
  });

  void _confirmRemoveSelected(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Hapus Item Terpilih"),
        content: Text("Yakin hapus ${selectedItems.length} barang terpilih?"),
        actions: <Widget>[
          TextButton(
            child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
            onPressed: () {
              cartNotifier.removeSelectedItems();
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          Checkbox(
            value: allSelected,
            activeColor: primaryColor,
            onChanged: (val) {
              cartNotifier.toggleSelectAll(val ?? false);
            },
          ),
          const Text("Pilih semua"),
          const Spacer(),
          TextButton(
            onPressed: selectedItems.isEmpty ? null : () => _confirmRemoveSelected(context),
            child: Text(
              "Hapus (${selectedItems.length})",
              style: TextStyle(
                color: selectedItems.isEmpty ? Colors.grey : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}