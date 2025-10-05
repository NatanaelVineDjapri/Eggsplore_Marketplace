import 'package:eggsplore/model/user.dart';
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
import 'package:eggsplore/pages/search/search_page.dart';
import 'package:eggsplore/widget/bannerSlider.dart';

// Provider untuk mengambil data user
final userProvider = FutureProvider<User>((ref) async {
  return UserService.getCurrentUser();
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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

  // Fungsi untuk navigasi ke halaman Eggsplore Pay dan refresh user data
  void _navigateToEggsplorePay() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EggsplorePayPage()),
    );

    // Setelah kembali, refresh user data
    if (mounted) {
      ref.invalidate(userProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = Appsized(context);
    final bgHeight = size.height * 0.36;

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
                    onChatTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatPage(),
                      ),
                    ),
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
                ),
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    children: [
                      const BannerSlider(
                        images: [
                          "assets/images/banner.jpg",
                          "assets/images/banner.jpg",
                          "assets/images/banner.jpg",
                        ],
                      ),

                      // Tampilkan saldo dari user provider
                      userAsyncValue.when(
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (err, stack) => Center(
                          child: Text("Gagal memuat user: $err"),
                        ),
                        data: (user) => EggsplorePayCard(
                          balance: user.balance,
                          onTap: _navigateToEggsplorePay,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(size.md),
                        child: Consumer(
                          builder: (context, ref, child) {
                            final productsAsync = ref.watch(allProductsProvider);
                            return productsAsync.when(
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              error: (err, stack) => Center(
                                child: Text("Gagal load produk: $err"),
                              ),
                              data: (products) {
                                if (products.isEmpty) {
                                  return const Center(
                                    child: Text("Belum ada produk"),
                                  );
                                }
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: products.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
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
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
