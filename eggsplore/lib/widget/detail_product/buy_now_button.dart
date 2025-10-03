import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/pages/checkout_page.dart';
import 'package:eggsplore/provider/auth_provider.dart';
import 'package:eggsplore/provider/checkout_provider.dart';
import 'package:eggsplore/service/checkout_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../constants/colors.dart'; // Jika AppColors dibutuhkan, pastikan diimpor

class BuyNowButton extends ConsumerWidget {
  final Color color;
  final Product product;
  
  const BuyNowButton({
    super.key,
    required this.color,
    required this.product,
  });

  // Fungsi yang dipanggil saat tombol Buy Now ditekan
  // KINI: Menerima objek User yang dijamin non-null dari build()
  void _showQuantityDialog(BuildContext context, WidgetRef ref, User user) {
    
    // Asumsi: user sudah diperiksa di method build sebelum dipanggil.
    if (product.stock == 0) return; 

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        int selectedQuantity = 1;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Pilih Kuantitas"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: selectedQuantity > 1 ? () => setState(() => selectedQuantity--) : null,
                  ),
                  Text(selectedQuantity.toString(), style: const TextStyle(fontSize: 20)),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.green),
                    onPressed: selectedQuantity < product.stock ? () => setState(() => selectedQuantity++) : null,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("Batal"),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
                ElevatedButton(
                  child: const Text("Lanjut Checkout"),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); 
                    // Meneruskan user yang dijamin NON-NULL dari parameter
                    _submitDirectBuy(context, ref, selectedQuantity, user); 
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Fungsi asinkron untuk memicu Direct Buy (DIHILANGKAN PENGECEKAN LOGIN)
  Future<void> _submitDirectBuy(BuildContext context, WidgetRef ref, int quantity, User user) async {
    
    // Tampilkan loading screen sebelum API call
    if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Memproses pesanan langsung...'))
        );
    }

    try {
      // Panggil Service dengan user yang sudah PASTI valid (non-null)
      final success = await CheckoutService.submitDirectBuy(
        product: product,
        user: user, // User dijamin non-null di sini
        quantity: quantity, 
      ); 

      // CEK MOUNTED SEBELUM UI (PENTING!)
      if (!context.mounted) return; 

      if (success) {
        // REFRESH PROVIDER dan NAVIGASI
        ref.invalidate(checkoutDataProvider); 

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Pesanan Langsung berhasil disiapkan!'))
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CheckoutPage()),
        );
      } else {
        throw Exception("Gagal menyiapkan data pesanan."); 
      }
    } catch (e) {
      // Tampilkan error dari service
      if (!context.mounted) return; 

      // KOREKSI FINAL: Menghilangkan RangeError dengan pengecekan contains(':')
      final errorString = e.toString();
      final displayMessage = errorString.contains(':') 
          ? errorString.split(':')[1].trim()
          : errorString; 

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal Beli Langsung: ${displayMessage}'),
          backgroundColor: Colors.red,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOutOfStock = product.stock == 0;
    final user = ref.watch(authProvider); // Dapatkan user di sini (metode build aman)
    
    // Tentukan aksi onPressed
    VoidCallback? onPressedAction;
    
    if (isOutOfStock) {
        onPressedAction = null; // Stok habis, disable
    } else if (user == null) {
        // Jika user NULL, tampilkan error login
        onPressedAction = () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Anda harus login untuk membeli.'), backgroundColor: Colors.red)
            );
        };
    } else {
        // Jika user NON-NULL dan stok ada, panggil dialog
        // Meneruskan objek user yang non-null ke dialog
        onPressedAction = () => _showQuantityDialog(context, ref, user);
    }
    
    return Expanded(
      flex: 3,
      child: ElevatedButton(
        // Gunakan logika onPressed yang sudah ditentukan
        onPressed: onPressedAction, 
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          isOutOfStock ? "Stok Habis" : "Beli Langsung", 
          style: const TextStyle(fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}