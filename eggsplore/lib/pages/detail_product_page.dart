import 'package:flutter/material.dart';
import 'package:eggsplore/widget/detail_product/topbar.dart';
import 'package:eggsplore/widget/detail_product/follow_button.dart';
import 'package:eggsplore/widget/detail_product/product_rating.dart';
import 'package:eggsplore/widget/detail_product/product_stock.dart';
import 'package:eggsplore/widget/detail_product/review_input.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TopBar(title: "Detail Produk"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Gambar produk
              Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                  image: const DecorationImage(
                    image: AssetImage("assets/images/sample_product.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Nama produk
              const Text(
                "Telur 1 Kg Ayam Kampung",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              // 🔹 Harga
              const Text(
                "Rp 25.000",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),

              const Divider(
                color: Colors.orange,
                thickness: 1,
                height: 24,
              ),

              // 🔹 Deskripsi
              const Text(
                "Deskripsi Produk",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "Telur ayam kampung segar, diambil langsung dari peternakan lokal. "
                "Bebas bahan kimia, sehat, dan cocok untuk kebutuhan harian.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const Divider(
                color: Colors.orange,
                thickness: 1,
                height: 24,
              ),

              // 🔹 Akun / pemilik toko + FollowButton
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.store, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Toko Sehat Jaya",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Online 5 menit lalu",
                          style: TextStyle(fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  FollowButton(
                    isInitiallyFollowing: false,
                    onFollow: () {
                      debugPrint("Followed toko");
                    },
                    onUnfollow: () {
                      debugPrint("Unfollowed toko");
                    },
                  ),
                ],
              ),

              const Divider(
                color: Colors.orange,
                thickness: 1,
                height: 24,
              ),

              // 🔹 Rating & stok
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ProductRating(averageRating: 4.5, totalReviews: 120),
                  ProductStock(stock: 35),
                ],
              ),

              const Divider(
                color: Colors.orange,
                thickness: 1,
                height: 24,
              ),

              // 🔹 Review input
              ReviewInput(
                onSubmit: (rating, comment) {
                  debugPrint("Rating: $rating, Comment: $comment");
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
