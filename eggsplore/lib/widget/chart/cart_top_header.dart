import 'package:eggsplore/widget/chart/remove_shop_dialog.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/provider/cart_provider.dart';

class CartShopHeader extends StatelessWidget {
  final String shopName;
  final bool allShopSelected;
  final CartNotifier cartNotifier;
  final Color primaryColor;

  const CartShopHeader({
    super.key,
    required this.shopName,
    required this.allShopSelected,
    required this.cartNotifier,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Checkbox(
            value: allShopSelected,
            activeColor: primaryColor,
            onChanged: (val) {
              if (val != null) {
                cartNotifier.toggleShopSelect(shopName, val);
              }
            },
          ),
          const Icon(Icons.store, color: Colors.grey, size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              shopName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.grey,
              size: 24,
            ),
            onPressed: () => showRemoveShopConfirmationDialog(
              context: context,
              shopName: shopName,
              cartNotifier: cartNotifier,
              primaryColor: primaryColor,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
