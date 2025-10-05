import 'package:flutter/material.dart';
import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/widget/trending_product_card.dart';
import 'package:eggsplore/widget/TopNavBar.dart';

// 🔹 Import SearchPage
import 'package:eggsplore/pages/search/search_page.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  final List<Map<String, String>> products = [
    {
      "name": "Telur 1kg",
      "price": "Rp. 25.000",
      "image": "assets/images/eggs.jpg",
    },
    {
      "name": "Ayam Potong 1 Ekor",
      "price": "Rp. 40.000",
      "image": "assets/images/chicken.jpg",
    },
    {
      "name": "Cabai 500gr",
      "price": "Rp. 30.000",
      "image": "assets/images/chili.jpg",
    },
    {
      "name": "ZGMF-X10A Freedom Gundam",
      "price": "Rp. 1.500.000",
      "image": "assets/images/gundam.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 Background image
          Positioned.fill(child: Container(color: Colors.orange)),

          /// 🔹 Foreground content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔎 Top Navigation Bar (Search + Chat)
                  TopNavBar(
                    onChatTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Chat tapped!")),
                      );
                    },
                    // 🔹 Sama kayak HomePage → pindah ke SearchPage
                    onSearch: (value) {
                      final query = value.trim();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SearchPage(query: query),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  /// 🔥 Banner trending pakai image (langsung gambar figma)
                  Center(
                    child: Image.asset(
                      "assets/images/trending.png",
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// 🛒 Produk list (grid)
                  Expanded(
                    child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return TrendingProductCard(
                          name: product["name"]!,
                          price: product["price"]!,
                          // image: product["image"], // aktifin kalau mau pake gambar asli
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}
