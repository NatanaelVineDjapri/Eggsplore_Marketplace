import 'package:eggsplore/constants/colors.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/widget/TopNavBar.dart';
import 'package:eggsplore/pages/search/search_page.dart';
import 'package:eggsplore/service/product_service.dart';
import 'package:eggsplore/model/product.dart'; // buat model data
import 'package:eggsplore/widget/product.dart'; // buat ProductCard widget

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  List<Product> trendingProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTrendingProducts();
  }

  Future<void> loadTrendingProducts() async {
    try {
      final products = await ProductService.fetchTrendingProducts();
      setState(() {
        trendingProducts = products;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetch trending: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
  children: [
    /// Background
    Positioned.fill(
      child: Image.asset(
        AppImages.trending_bg,
        fit: BoxFit.cover,
      ),
    ),

    /// Overlay transparan (opsional biar konten keliatan jelas)
    Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.3),
      ),
    ),

    /// Konten
    SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopNavBar(
              onChatTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Chat tapped!")),
                );
              },
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

            /// Judul tengah
            const Center(
              child: Text(
                "TRENDING",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : trendingProducts.isEmpty
                      ? const Center(
                          child: Text(
                            "Belum ada produk trending",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : GridView.builder(
                          itemCount: trendingProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            final product = trendingProducts[index];
                            return ProductCard(
                              productId: product.id!,
                              name: product.name,
                              price:
                                  double.parse(product.price.toString()),
                              image: product.image,
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