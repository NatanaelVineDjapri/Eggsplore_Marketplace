import 'package:flutter/material.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/widget/profile/profile_info_card.dart';
import 'package:eggsplore/widget/profile/profile_shop_card.dart';
import 'package:eggsplore/widget/profile/profile_actions_card.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/constants/text_style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 Background Image full
          Positioned.fill(
            child: Image.asset(
              AppImages.profileHeader,
              fit: BoxFit.cover,   // biar full width & tinggi
              alignment: Alignment.topCenter,
            ),
          ),

          /// 🔹 Foreground content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      ProfileInfoCard(),
                      SizedBox(width: 12),
                      ProfileShopCard(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const ProfileActionsCard(),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      AppStrings.myWishlist,
                      style: AppTextStyle.mainTitle2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }
}
