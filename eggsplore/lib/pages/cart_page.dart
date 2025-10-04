import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/constants/colors.dart';
import 'package:eggsplore/widget/chart/cart_item.dart';
import 'package:eggsplore/widget/chart/cart_top_bar.dart';
import 'package:eggsplore/widget/chart/cart_bottom_bar.dart';
import 'package:eggsplore/widget/chart/cart_select_all_header.dart';
import 'package:eggsplore/widget/chart/cart_top_header.dart';
import 'package:eggsplore/widget/chart/remove_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/cart_item.dart';
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
    Future.microtask(() => ref.read(cartProvider.notifier).loadCart());
  }

  final Color appPrimaryColor = Colors.red.shade700;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = AppColors.primary;

    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    final selectedItems = cartNotifier.selectedItems;
    final totalPrice = cartNotifier.selectedTotalPrice;
    final allSelected = cartNotifier.allSelected;

    final Map<String, List<CartItem>> groupedItems = {};
    for (var item in cartItems) {
      final shop = item.shopName;
      groupedItems.putIfAbsent(shop, () => []).add(item);
    }

    return Scaffold(
      // FIX FINAL: Panggil CartTopBar sebagai AppBar
      appBar: CartTopBar(primaryColor: primaryColor),
      body: cartItems.isEmpty
          ? const Center(child: Text("Keranjang masih kosong 🛒"))
          : ListView(
              padding: const EdgeInsets.only(bottom: 80),
              children: [
                CartSelectAllHeader(
                  primaryColor: primaryColor,
                  cartNotifier: cartNotifier,
                  allSelected: allSelected,
                  selectedItems: selectedItems,
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFE0E0E0),
                ),

                ...groupedItems.entries.map((entry) {
                  final shopName = entry.key;
                  final items = entry.value;
                  final allShopSelected = items.every((i) => i.isSelected);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CartShopHeader(
                        shopName: shopName,
                        allShopSelected: allShopSelected,
                        cartNotifier: cartNotifier,
                        primaryColor: primaryColor,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 0.5,
                        color: Color(0xFFE0E0E0),
                      ),

                      ...items.map((item) {
                        return Column(
                          children: [
                            CartItemWidget(
                              item: item,
                              onQuantityChanged: (newQty) {
                                cartNotifier.updateItem(item.id, newQty);
                              },
                              onRemove: () => showRemoveItemConfirmationDialog(
                                context: context,
                                item: item,
                                primaryColor: primaryColor,
                                cartNotifier: cartNotifier,
                              ),
                              onToggleSelect: (_) =>
                                  cartNotifier.toggleSelect(item.id),
                            ),
                            const Divider(
                              height: 1,
                              thickness: 0.5,
                              color: Color(0xFFE0E0E0),
                            ),
                          ],
                        );
                      }),

                      Container(height: 10, color: const Color(0xFFF0F0F0)),
                    ],
                  );
                }),
              ],
            ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Bar Checkout (Total Harga / Beli)
          CartBottomBar(
            totalPrice: totalPrice,
            selectedItems: selectedItems,
            primaryColor: primaryColor,
          ),
          // 2. Bar Navigasi Utama (Home/Cart/Profile)
          const CustomBottomNavBar(currentIndex: 1), // Index 1 = Cart
        ],
      ),
    );
  }
}
