import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eggsplore/widget/TopNavBar.dart';
import 'package:eggsplore/widget/eggsplore_pay/Eggsplore_Pay_Card.dart';
import 'package:eggsplore/pages/eggsplore_pay_page.dart';
import 'package:eggsplore/pages/chat_page.dart';
import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/service/product_service.dart';
import 'package:eggsplore/widget/product.dart';
import 'package:intl/intl.dart';
import 'package:eggsplore/pages/search_page.dart';
import 'package:eggsplore/widget/bannerSlider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double balance = 0;

  // Scroll controller & offset untuk menggerakkan background
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  Future<List<Product>> _loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    if (token.isEmpty) {
      throw Exception("User belum login atau token kosong");
    }
    return ProductService.fetchProducts(token);
  }

  @override
  void initState() {
    super.initState();
    _loadUser();

    // Listener scroll: update offset untuk background
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
    final formatter = NumberFormat('#,###');

    final bgHeight = size.height * 0.36;
    // pastikan top hanya antara -bgHeight .. 0
    final bgTop = -_scrollOffset.clamp(0.0, bgHeight).toDouble();

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background image (mentok atas, full lebar)
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

          // 🔹 Konten di atas background, pake SafeArea biar gak ketiban status bar
          SafeArea(
            child: Column(
              children: [
                // TopNavBar
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

                // Scrollable content
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    children: [
                      BannerSlider(
                        images: [
                          "assets/images/banner.jpg",
                          "assets/images/banner.jpg",
                          "assets/images/banner.jpg",
                        ],
                      ),
                      EggsplorePayCard(
                        balance: balance,
                        onTap: () async {
                          final newBalance = await Navigator.push<double>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EggsplorePayPage(),
                            ),
                          );
                          if (newBalance != null) {
                            setState(() => balance = newBalance);
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(size.md),
                        child: FutureBuilder<List<Product>>(
                          future: _loadProducts(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  "Gagal load produk: ${snapshot.error}",
                                ),
                              );
                            }

                            final products = snapshot.data ?? [];
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
