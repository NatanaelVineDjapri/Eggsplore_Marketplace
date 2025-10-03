import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:intl/intl.dart'; 
// FIX IMPORT: Ubah 'cart_page.dart' menjadi path yang benar jika berada di folder yang sama/dekat
import './cart_page.dart'; // <<< Asumsi path yang benar
// Import Provider dan Service
import '../provider/checkout_provider.dart'; 
import '../service/checkout_service.dart'; 
import '../model/checkout_data.dart'; 
// import '../pages/order_history_page.dart'; // Tambahkan ini jika sudah ada

class CheckoutPage extends ConsumerWidget { 
    const CheckoutPage({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
        final checkoutAsync = ref.watch(checkoutDataProvider); 
        
        final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
        final balanceFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 3);

        return Scaffold(
            backgroundColor: const Color(0xFFDADADA), 
            body: Column(
                children: [
                    // HEADER 
                    Container(
                        padding: const EdgeInsets.only(
                            top: 40, left: 16, right: 16, bottom: 16,
                        ),
                        color: Colors.orange,
                        child: Row(
                            children: [
                                GestureDetector(
                                    onTap: () {
                                        // LOGIC: Kembali ke CartPage
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => const CartPage()),
                                        );
                                    },
                                    child: const Icon(Icons.arrow_back, color: Colors.black),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                    "Checkout",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                            ],
                        ),
                    ),

                    // BODY: ASYNC DATA
                    Expanded(
                        child: checkoutAsync.when(
                            loading: () => const Center(child: CircularProgressIndicator(color: Colors.orange)),
                            error: (err, stack) => Center(child: Text('Gagal memuat data: $err')),
                            data: (data) {
                                return SingleChildScrollView(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                        children: [
                                            // 1. SECTION IDENTITAS/ALAMAT
                                            _buildBox(
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                        Text(data.user.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                        const SizedBox(height: 4),
                                                        Text("(+62) ${data.user.phoneNumber ?? '-'}"),
                                                        const SizedBox(height: 4),
                                                        Text(data.user.address ?? 'Alamat belum diatur.', style: const TextStyle(color: Colors.black54)),
                                                    ],
                                                ),
                                            ),
                                            const SizedBox(height: 12),

                                            // 2. SECTION PRODUK
                                            _buildBox(
                                                child: Row(
                                                    children: [
                                                        Container(width: 70, height: 70, color: Colors.grey[300], child: const Icon(Icons.image, size: 40, color: Colors.black45)),
                                                        const SizedBox(width: 12),
                                                        Expanded(
                                                            child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                    Text(data.cartItems.first.shopName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                    const SizedBox(height: 2),
                                                                    Text(data.cartItems.first.name, style: const TextStyle(color: Colors.black54)),
                                                                    const SizedBox(height: 6),
                                                                    Text(currencyFormatter.format(data.cartItems.first.price), style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                ],
                                                            ),
                                                        ),
                                                        Text("x${data.cartItems.first.quantity}"),
                                                    ],
                                                ),
                                            ),
                                            const SizedBox(height: 12),

                                            // 3. SECTION RINCIAN PEMBAYARAN
                                            _buildBox(
                                                child: Column(
                                                    children: [
                                                        _buildRow("Subtotal Pesanan", currencyFormatter.format(data.itemsSubtotal)),
                                                        _buildRow("Subtotal Pengiriman", currencyFormatter.format(data.shippingFee)),
                                                        _buildRow("Biaya Layanan", currencyFormatter.format(data.serviceFee)),
                                                        const Divider(color: Colors.orange, thickness: 1),
                                                        _buildRow("Total Pembayaran", currencyFormatter.format(data.grandTotal), isBold: true),
                                                    ],
                                                ),
                                            ),
                                            const SizedBox(height: 12),

                                            // 4. SECTION METODE PEMBAYARAN
                                            _buildBox(
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                        const Text("Pilih metode pembayaran", style: TextStyle(fontWeight: FontWeight.bold)),
                                                        const SizedBox(height: 12),
                                                        Container(
                                                            width: double.infinity,
                                                            padding: const EdgeInsets.all(12),
                                                            decoration: BoxDecoration(
                                                                color: Colors.grey[100],
                                                                borderRadius: BorderRadius.circular(8),
                                                                border: Border.all(color: Colors.orange),
                                                            ),
                                                            child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                    const Text("Bayar dengan:"),
                                                                    const SizedBox(height: 6),
                                                                    const Row(
                                                                        children: [
                                                                            Icon(Icons.circle, size: 14, color: Colors.orange),
                                                                            SizedBox(width: 6),
                                                                            Text("EggsplorePay"),
                                                                        ],
                                                                    ),
                                                                    const SizedBox(height: 6),
                                                                    Text(balanceFormatter.format(data.user.balance).replaceAll(',000', '').replaceAll('Rp', 'Rp ')),
                                                                ],
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                        ],
                                    ),
                                );
                            },
                        ),
                    ),

                    // BOTTOM BAR
                    checkoutAsync.when(
                        data: (data) => _buildBottomBar(context, ref, data),
                        loading: () => const SizedBox(height: 80),
                        error: (err, stack) => const SizedBox(height: 80), 
                    ),
                ],
            ),
        );
    }

    // --- HELPER METHODS (TETAP SAMA) ---

    Widget _buildBottomBar(BuildContext context, WidgetRef ref, CheckoutData data) {
        final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
                color: Colors.orange,
                boxShadow: [
                    BoxShadow(color: Colors.black26, offset: Offset(0, -2), blurRadius: 4),
                ],
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            const Text("Total", style: TextStyle(fontSize: 14)),
                            const SizedBox(height: 4),
                            Text(
                                currencyFormatter.format(data.grandTotal),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                        ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () async {
                            // AKSI CHECKOUT NYATA
                            if (!context.mounted) return;
                            
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Memproses transaksi...')));
                            
                            try {
                                final success = await CheckoutService.submitOrder(data); 

                                if (!context.mounted) return;

                                if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ Pembayaran Berhasil! Pesanan diproses.')));
                                    // TODO: NAVIGASI KE HALAMAN RIWAYAT PESANAN (OrderHistoryPage)
                                } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('❌ Transaksi Gagal. Saldo tidak cukup atau error server.'), backgroundColor: Colors.red));
                                }
                            } catch (e) {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Colors.red));
                            }
                        },
                        child: const Text("Checkout"),
                    ),
                ],
            ),
        );
    }
    
    Widget _buildBox({required Widget child}) {
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
            ),
            child: child,
        );
    }

    Widget _buildRow(String label, String value, {bool isBold = false}) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(
                        label,
                        style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
                    ),
                    Text(
                        value.replaceAll(',00', ''),
                        style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
                    ),
                ],
            ),
        );
    }
}