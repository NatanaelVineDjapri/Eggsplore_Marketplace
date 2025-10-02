import 'package:eggsplore/model/cart_item.dart';
import 'package:eggsplore/widget/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/provider/cart_provider.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(cartProvider.notifier).loadCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    // Grup item berdasarkan toko
    final Map<String, List<CartItem>> groupedItems = {};
    for (var item in cartItems) {
      final store = item.name ?? "Toko Tidak Diketahui";
      if (!groupedItems.containsKey(store)) {
        groupedItems[store] = [];
      }
      groupedItems[store]!.add(item);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Keranjang masih kosong"))
          : ListView(
              children: groupedItems.entries.map((entry) {
                final storeName = entry.key;
                final items = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      color: Colors.grey[200],
                      child: Text(
                        storeName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...items.map((item) => CartItemWidget(
                          item: item,
                          onQuantityChanged: (newQty) async {
                            try {
                              await cartNotifier.updateItem(item.id, newQty);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Gagal update: $e")),
                              );
                            }
                          },
                          onRemove: () async {
                            try {
                              await cartNotifier.removeItem(item.id);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Gagal hapus: $e")),
                              );
                            }
                          },
                        )),
                  ],
                );
              }).toList(),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: Rp ${cartNotifier.totalPrice.toStringAsFixed(0)}",
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Checkout belum dibuat")),
                );
              },
              child: const Text("Checkout"),
            )
          ],
        ),
      ),
    );
  }
}
