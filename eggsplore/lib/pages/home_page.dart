import 'package:eggsplore/model/user.dart'; // <-- PASTIKAN IMPORT MODEL USER
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:eggsplore/widget/TopNavBar.dart';
import 'package:eggsplore/widget/eggsplore_pay/Eggsplore_Pay_Card.dart';
import 'package:eggsplore/pages/eggsplore_pay_page.dart';
import 'package:eggsplore/pages/chat_page.dart';
import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/provider/product_provider.dart';
import 'package:eggsplore/widget/product.dart';
import 'package:eggsplore/pages/search_page.dart';
import 'package:eggsplore/widget/bannerSlider.dart';

// LANGKAH 1: Buat Provider untuk mengambil data user
// (Anda bisa pindahkan ini ke file provider terpisah, misal: provider/user_provider.dart)
final userProvider = FutureProvider<User>((ref) {
  return UserService.getCurrentUser();
});


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // Kita tidak perlu lagi state 'balance' dan fungsi _loadUser()
  // karena semuanya sudah ditangani oleh Riverpod.

  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (!mounted) return;
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // LANGKAH 2: Buat fungsi navigasi yang me-refresh provider
  void _navigateToEggsplorePay() async {
    // Navigasi ke halaman Top Up
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EggsplorePayPage()),
    );

    // Setelah kembali dari halaman Top Up, refresh userProvider
    // agar data saldo yang baru diambil ulang dari server.
    if (mounted) {
      ref.invalidate(userProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = Appsized(context);
    final bgHeight = size.height * 0.36;

    // LANGKAH 3: 'watch' provider user di dalam build method
    final userAsyncValue = ref.watch(userProvider);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -_scrollOffset.clamp(0.0, bgHeight).toDouble(),
            left: 0,
            right: 0,
            height: bgHeight,
            child: Image.asset(
              AppImages.homeHeader,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.md,
                    vertical: size.sm,
                  ),
                  child: TopNavBar(
                    onChatTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatPage())),
                    onSearch: (value) {
                      final query = value.trim();
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SearchPage(query: query)));
                    },
                  ),
                ),
                Expanded(
                  // LANGKAH 4: Gunakan .when() untuk menangani state loading, error, dan data
                  child: userAsyncValue.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text("Gagal memuat data: ${err.toString()}")),
                    data: (user) => ListView( // <-- data user berhasil dimuat
                      controller: _scrollController,
                      padding: EdgeInsets.zero,
                      children: [
                        const BannerSlider(
                          images: [
                            "assets/images/banner.jpg", "assets/images/banner.jpg", "assets/images/banner.jpg",
                          ],
                        ),
                        // LANGKAH 5: Gunakan data user untuk balance dan onTap
                        EggsplorePayCard(
                          balance: user.balance,
                          onTap: _navigateToEggsplorePay, // <-- Panggil fungsi navigasi
                        ),
                        Padding(
                          padding: EdgeInsets.all(size.md),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final productsAsync = ref.watch(allProductsProvider);
                              return productsAsync.when(
                                loading: () => const Center(child: CircularProgressIndicator()),
                                error: (err, stack) => Center(child: Text("Gagal load produk: $err")),
                                data: (products) {
                                  if (products.isEmpty) {
                                    return const Center(child: Text("Belum ada produk"));
                                  }
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: products.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: size.sm,
                                      mainAxisSpacing: size.sm,
                                      childAspectRatio: 0.7,
                                    ),
                                    itemBuilder: (context, index) {
                                      final product = products[index];
                                      return ProductCard(
                                        productId: product.id,
                                        name: product.name,
                                        price: product.price,
                                        image: product.image,
                                      );
                                    },
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
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}