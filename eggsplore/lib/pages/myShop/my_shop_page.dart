import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/widget/shop_info_card.dart';
import 'package:eggsplore/widget/shop_actions_card.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/pages/myShop/modify_shop_info.dart';
import 'package:eggsplore/constants/images.dart';

class MyShopPage extends StatefulWidget {
  const MyShopPage({super.key});

  @override
  State<MyShopPage> createState() => _MyShopPageState();
}

class _MyShopPageState extends State<MyShopPage> {
  String shopName = AppStrings.shopName;
  String followers = "120";
  String buyers = "85";
  String rating = "4.8";
  String imagePath = AppImages.firstLogo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const backBar(title: "My Shop"),
      body: Container(
        // 🔹 Base color + pattern overlay
        decoration: BoxDecoration(
          color: const Color(0xFFFFAE11), // warna dasar tetap ada
          image: DecorationImage(
            image: AssetImage(AppImages.shopPattern),
            fit: BoxFit.cover,       // biar kiri–kanan penuh
            repeat: ImageRepeat.repeatY, // ulang ke bawah saat scroll
            alignment: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShopInfoCard(
                shopName: shopName,
                followers: followers,
                buyers: buyers,
                rating: rating,
                imagePath: imagePath,
                onModify: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyShopPage(),
                    ),
                  );
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
            ],
          ),
        ),
      ),
    );
  }
}
