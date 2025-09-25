import 'package:flutter/material.dart';
import 'package:eggsplore/widget/TopNavBar.dart';
import 'package:eggsplore/widget/eggsplore_pay/Eggsplore_Pay_Card.dart';
import 'package:eggsplore/widget/eggsplore_pay/banner_card.dart';
import 'package:eggsplore/pages/eggsplore_pay_page.dart';
import 'package:eggsplore/pages/chat_page.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(''),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TopNavBar(
              onChatTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
              },
              onSearch: (value) {
                print("Search: $value");
              },
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          const BannerCard(imagePath: "assets/images/banner.jpg"),
          EggsplorePayCard(
            balance: balance,
            onTap: () async {
              final newBalance = await Navigator.push<double>(
                context,
                MaterialPageRoute(
                  builder: (context) => EggsplorePayPage(balance: balance),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/home.png"),
              size: 30,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/profile.png"),
              size: 30,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}