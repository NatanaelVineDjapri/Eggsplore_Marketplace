import 'package:eggsplore/constants/text_string.dart';
import 'package:flutter/material.dart';

class ShopProfilePage extends StatelessWidget {
  const ShopProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header dengan background kuning
          Container(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
            color: Colors.orange,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar
                Row(
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.black),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: AppStrings.findinshop,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Info toko
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar toko
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(width: 12),

                    // Nama toko + lokasi + rating
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ayam Kecap",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Jakarta Barat",
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(height: 4),

                          // Rating & terjual
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(Icons.star, size: 16, color: Colors.black),
                              SizedBox(width: 4),
                              Text("4.8 (20)", style: TextStyle(fontSize: 14)),
                              SizedBox(width: 12),
                              Text("100 terjual", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Tombol Follow
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("Follow", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // List produk
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar produk
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Container(
                              color: Colors.grey[300], // placeholder image
                              child: const Center(
                                child: Icon(Icons.image, size: 40, color: Colors.black45),
                              ),
                            ),
                          ),
                        ),

                        // Info produk
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Ayam Potong 1 Ekor",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              SizedBox(height: 4),
                              Text(
                                "Rp. 1.000.000",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
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
          ),
        ],
      ),
    );
  }
}
