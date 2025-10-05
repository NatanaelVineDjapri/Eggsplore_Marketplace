import 'package:eggsplore/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/model/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;
  final ValueChanged<bool?> onToggleSelect;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.onToggleSelect,
  });

  final Color PrimaryColor = AppColors.primary;
  final TextStyle priceStyle = const TextStyle(
    color: Color(0xFFE52C2D),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  String formatRupiah(double amount) {
    final String str = amount.toStringAsFixed(0);
    return "Rp ${str.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  Widget _buildQuantityButton(
    IconData icon,
    bool enabled,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: enabled ? onPressed : null,
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? Colors.grey.shade700 : Colors.grey.shade300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 10, 16, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: item.isSelected,
            activeColor: PrimaryColor,
            onChanged: onToggleSelect,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: item.image != null
                ? Image.network(
                    item.image!,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(formatRupiah(item.price), style: priceStyle),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: onRemove, // Panggil onRemove
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 10),
                    // Quantity Control
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          _buildQuantityButton(
                            Icons.remove,
                            item.quantity > 0,
                            () {
                              if (item.quantity > 1) {
                                onQuantityChanged(item.quantity - 1);
                              } else {
                                onRemove();
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              item.quantity.toString(),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          _buildQuantityButton(Icons.add, true, () {
                            onQuantityChanged(item.quantity + 1);
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
