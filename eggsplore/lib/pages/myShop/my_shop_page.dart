// File: my_shop_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/model/shop.dart';
import 'package:eggsplore/service/shop_service.dart';
import 'package:eggsplore/pages/myShop/modify_shop_info.dart';
import 'package:eggsplore/widget/shop_actions_card.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/widget/shop_info_card.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/provider/product_provider.dart';
import 'package:eggsplore/widget/my_product_card.dart';

class MyShopPage extends ConsumerStatefulWidget {
  const MyShopPage({super.key});

  @override
  ConsumerState<MyShopPage> createState() => _MyShopPageState();
}

class _MyShopPageState extends State<MyShopPage> {
  Shop? _myShop;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMyShopData();
  }

  Future<void> _fetchMyShopData() async {
    Shop? shop = await ShopService.getMyShop();
    if (mounted) {
      setState(() {
        _myShop = shop;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = Appsized(context);
    final myProductsAsync = ref.watch(myProductsProvider);

    return Scaffold(
      appBar: const backBar(title: "My Shop"),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFAE11),
          image: DecorationImage(
            image: AssetImage(AppImages.shopPattern),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeatY,
            alignment: Alignment.topCenter,
          ),

          // LAPISAN 2: KONTEN (YANG BISA DI-SCROLL)
          // Widget ini diletakkan di atas background
          _buildShopContent(),
        ],
      ),
    );
  }

  Widget _buildShopContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    if (_myShop == null) {
      // ... (kode untuk 'Anda belum memiliki toko' tidak berubah)
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Anda belum memiliki toko.", style: AppTextStyle.mainTitle2),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: Arahkan ke halaman pembuatan toko
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.orange),
              child: const Text("Buat Toko Sekarang"),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchMyShopData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShopInfoCard(
              shopName: _myShop!.name,
              description: _myShop!.description,
              imagePath: _myShop!.image,
              followers: "120",
              buyers: "85",
              rating: "4.8",
              onModify: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ModifyShopInfoPage(),
                  ),
                ).then((_) => _fetchMyShopData());
              },
            ),
            const SizedBox(height: 20),
            const ShopActionsCard(),
            const SizedBox(height: 20),
            Center(
              child: Text(
                AppStrings.myProducts,
                style: AppTextStyle.mainTitle2,
                textAlign: TextAlign.center,
              ),
            ),
            // TODO: Tambahkan daftar produk di sini
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Expanded( // 🌟 Tambahkan Expanded di sini
              child: myProductsAsync.when(
                data: (products) {
                  if (products.isEmpty) {
                    // 🌟 Menggunakan Center tanpa SizedBox agar pas di dalam Expanded
                    return const Center(
                      child: Text(
                        "Belum ada produk.",
                        style: TextStyle(fontSize: 16, color: Colors.black54), // Ubah ukuran font di sini
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
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
                        return MyProductCard(
                          productId: product.id,
                          name: product.name,
                          price: product.price,
                          image: product.image,
                        );
                      },
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text("Error: $err")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}