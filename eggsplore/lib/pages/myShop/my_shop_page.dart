import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/widget/shop_info_card.dart';
import 'package:eggsplore/widget/shop_actions_card.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/pages/myShop/modify_shop_info.dart';

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
  String imagePath = "assets/logo/eggsplore1.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffae11),
      appBar: const backBar(title: "My Shop"),
      body: Padding(
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
                    builder: (context) => const ModifyShopInfoPage(),
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
    );
  }
}
