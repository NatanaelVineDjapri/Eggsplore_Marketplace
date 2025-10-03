import 'package:flutter/material.dart';
import 'cart_page.dart'; // ✅ Import CartPage

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDADADA), // Background abu-abu
      body: Column(
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.only(
              top: 40,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            color: Colors.orange,
            child: Row(
              children: [
                // ✅ Back button menuju CartPage
                GestureDetector(
                  onTap: () {
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

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // SECTION IDENTITAS
                  _buildBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Claudioooooooo",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text("(+62) 87884848484"),
                        SizedBox(height: 4),
                        Text(
                          "Jl. letjen s.parman blok 123 no 5 lorem ipsum dolor sit amet constectuoer",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // SECTION PRODUK
                  _buildBox(
                    child: Row(
                      children: [
                        // IMAGE placeholder
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.image,
                            size: 40,
                            color: Colors.black45,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // INFO produk
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Claudiva Official",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "Capybara Import",
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Rp 999.999.999",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        // JUMLAH
                        const Text("x1"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // SECTION RINCIAN PEMBAYARAN
                  _buildBox(
                    child: Column(
                      children: [
                        _buildRow("Subtotal Pesanan", "Rp 999.999.999"),
                        _buildRow("Subtotal Pengiriman", "Rp 100.000"),
                        _buildRow("Biaya Layanan", "Rp 1.000"),
                        const Divider(color: Colors.orange, thickness: 1),
                        _buildRow(
                          "Total Pembayaran",
                          "Rp 1.000.100.999",
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // SECTION METODE PEMBAYARAN
                  _buildBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pilih metode pembayaran",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                            children: const [
                              Text("Bayar dengan:"),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 14,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 6),
                                  Text("EggsplorePay"),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text("Saldo: Rp 2.000.000.000"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BOTTOM BAR dengan shadow
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.orange,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, -2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Total", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 4),
                    Text(
                      "Rp 1.000.100.999",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Checkout"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable box
  Widget _buildBox({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, // box putih
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  // Reusable row untuk rincian
  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
