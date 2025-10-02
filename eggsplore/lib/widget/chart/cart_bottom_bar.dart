import 'package:flutter/material.dart';
import 'package:eggsplore/model/cart_item.dart';
import 'package:eggsplore/constants/colors.dart';

class CartBottomBar extends StatelessWidget {
  final double totalPrice;
  final List<CartItem> selectedItems;
  final Color primaryColor;

  const CartBottomBar({
    super.key,
    required this.totalPrice,
    required this.selectedItems,
    required this.primaryColor,
  });

  final Color priceColor = const Color(0xFFE52C2D);

  String formatRupiah(double amount) {
    final String str = amount.toStringAsFixed(0);
    return "Rp ${str.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary, 
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total harga (${selectedItems.length} barang):",
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              Text(
                formatRupiah(totalPrice),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: priceColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedItems.isEmpty
                    ? Colors.grey
                    : primaryColor,
                elevation: 0,
                shadowColor: Colors.transparent,
                overlayColor: primaryColor.withOpacity(0.1),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.zero,
              ),
              onPressed: selectedItems.isEmpty
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Checkout (Lanjutkan ke Pembayaran) belum dibuat",
                          ),
                        ),
                      );
                    },
              // CHILD: KOTAK PUTIH DI DALAM TOMBOL MERAH
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Beli",
                  style: TextStyle(
                    color: primaryColor, // Teks Merah/Primary
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
