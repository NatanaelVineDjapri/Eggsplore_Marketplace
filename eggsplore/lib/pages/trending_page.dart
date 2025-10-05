import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/pages/search_page.dart';
import 'package:eggsplore/pages/provider/product_provider.dart';
import 'package:eggsplore/widget/product.dart';
import 'package:eggsplore/widget/TopNavBar.dart';

class TrendingPage extends ConsumerWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingProductsAsync = ref.watch(trendingProductsProvider);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/backgroundtrending.png"), 
                  fit: BoxFit.cover, 
                ),
              ),
            ),
          ),
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
                        MaterialPageRoute(builder: (_) => SearchPage(query: query)),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Image.asset(
                      "assets/images/trendingcard.png",
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: trendingProductsAsync.when(
                      loading: () => const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                      error: (err, stack) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Gagal memuat produk: ${err.toString()}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      data: (products) {
                        if (products.isEmpty) {
                          return const Center(
                            child: Text(
                              'Belum ada produk trending saat ini.',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        return GridView.builder(
                          itemCount: products.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              productId: product.id,
                              name: product.name,
                              price: product.price,
                              image: product.imageUrl ?? product.image,
                              isLiked: false,
                            );
                          },
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