import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/widget/TopNavBar.dart';
import 'package:eggsplore/widget/eggsplore_pay/Eggsplore_Pay_Card.dart';
import 'package:eggsplore/pages/chat_page.dart';
import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/provider/product_provider.dart';
import 'package:eggsplore/widget/product.dart';
import 'package:eggsplore/pages/search_page.dart';
import 'package:eggsplore/widget/bannerSlider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  double balance = 0;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _loadUser();

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

  void _loadUser() async {
    final user = await UserService.getCurrentUser();
    if (user != null) {
      setState(() {
        balance = user.balance;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = Appsized(context);
    final bgHeight = size.height * 0.36;

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
                    onChatTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChatPage()),
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
                      EggsplorePayCard(
                        balance: balance,
                        onTap: () {
                          // Logika onTap untuk EggsplorePayPage tidak disertakan
                          // karena membutuhkan penanganan state `balance` yang lebih kompleks
                          // jika halaman tersebut mengembalikan nilai.
                        },
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