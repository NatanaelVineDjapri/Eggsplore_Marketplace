import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/pages/search/search_page.dart';
import 'package:eggsplore/provider/shop_provider.dart';
import 'package:eggsplore/widget/TopNavBar.dart';
import 'package:eggsplore/widget/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/colors.dart';
import 'chat_page.dart';
import 'chat_account_page.dart';

class ShopProfilePage extends ConsumerWidget {
  final int shopId;
  const ShopProfilePage({super.key, required this.shopId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopState = ref.watch(shopProvider(shopId));

    return Scaffold(
      body: shopState.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.orange)),
        error: (error, stack) => Center(child: Text("Gagal memuat data: $error")),
        data: (shopData) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                backgroundColor: AppColors.white,
                elevation: 1,
                automaticallyImplyLeading: true,
                title: TopNavBar(
                  onChatTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatPage()),
                    );
                  },
                  onSearch: (value) {
                    final query = value.trim();
                    if (query.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SearchPage(query: query)),
                      );
                    }
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    shopData.shop.image,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.3),
                    colorBlendMode: BlendMode.darken,
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(shopData.shop.image),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shopData.shop.name,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  shopData.shop.address,
                                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: const [
                              Text("4.8", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(height: 4),
                              Text("Rating & Ulasan", style: TextStyle(color: Colors.black54, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 24, child: VerticalDivider(color: Colors.grey)),
                          Column(
                            children: const [
                              Text("100+", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(height: 4),
                              Text("Produk Terjual", style: TextStyle(color: Colors.black54, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon( 
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatDetailPage(
                                      userId: shopData.shop.userId,
                                      username: shopData.shop.name,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.chat_bubble_outline), // Ini iconnya
                              label: const Text("Chat"), // Ini tulisannya
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black87,
                                side: BorderSide(color: Colors.grey.shade300),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                              label: const Text("Follow"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppColors.white,
                                backgroundColor: AppColors.primary,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(12.0),
                sliver: SliverGrid.builder(
                  itemCount: shopData.products.isEmpty ? 1 : shopData.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    if (shopData.products.isEmpty) {
                      return const Center(child: Text("Tidak ada produk."));
                    }
                    final product = shopData.products[index];
                    return ProductCard(
                      productId: product.id,
                      name: product.name,
                      price: product.price.toDouble(),
                      image: product.image,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}