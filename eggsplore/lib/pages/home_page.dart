import 'package:flutter/material.dart';
import 'package:eggsplore/widget/TopNavBar.dart';
import 'package:eggsplore/widget/eggsplore_pay/Eggsplore_Pay_Card.dart';
import 'package:eggsplore/widget/eggsplore_pay/banner_card.dart';
import 'package:eggsplore/pages/eggsplore_pay_page.dart';
import 'package:eggsplore/pages/chat_page.dart';
import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/constants/images.dart'; // 🔹 biar bisa pake AppImages

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double balance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 Background image
          Positioned.fill(
            child: Image.asset(
              AppImages.homeHeader,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          /// 🔹 Foreground content
          SafeArea(
            child: Column(
              children: [
                // TopNavBar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: TopNavBar(
                    onChatTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatPage(),
                        ),
                      );
                    },
                    onSearch: (value) {
                      print("Search: $value");
                    },
                  ),
                ),

                // Sisanya scrollable
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const BannerCard(imagePath: "assets/images/banner.jpg"),
                      EggsplorePayCard(
                        balance: balance,
                        onTap: () async {
                          final newBalance = await Navigator.push<double>(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EggsplorePayPage(balance: balance),
                            ),
                          );

                          if (newBalance != null) {
                            setState(() {
                              balance = newBalance;
                            });
                          }
                        },
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
