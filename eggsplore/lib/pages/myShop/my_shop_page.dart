import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/model/shop.dart';
import 'package:eggsplore/service/shop_service.dart';
import 'package:eggsplore/pages/myShop/modify_shop_info.dart';
import 'package:eggsplore/widget/shop_actions_card.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/widget/shop_info_card.dart';

class MyShopPage extends StatefulWidget {
  const MyShopPage({super.key});

  @override
  State<MyShopPage> createState() => _MyShopPageState();
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
    return Scaffold(
      appBar: const backBar(title: "My Shop"),
      // Kita tidak perlu warna background di Scaffold lagi
      body: Stack( // <-- PERBAIKAN UTAMA: GUNAKAN STACK
        children: [
          // LAPISAN 1: BACKGROUND ORANYE
          // Container ini akan mengisi seluruh ruang yang tersedia
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFAE11),
              image: DecorationImage(
                image: AssetImage(AppImages.shopPattern),
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeat, // Repeat di semua sumbu agar pola tidak putus
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}