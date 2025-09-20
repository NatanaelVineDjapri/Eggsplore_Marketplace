import 'package:flutter/material.dart';
import 'package:eggsplore/widget/TopNavBar.dart'; // pastikan nama file sesuai (huruf kecil semua)

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // ⬅️ panah back ilang
        title: const Text(''),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            color: Colors.grey[200], // ⬅️ background abu
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // ⬅️ jaga jarak
            child: TopNavBar(
              onChatTap: () {
                print("Chat tapped!");
              },
              onSearch: (value) {
                print("Search: $value");
              },
            ),
          ),
        ),
      ),
      body: Container(),
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
            label: "profile",
          ),
        ],
      ),
    );
  }
}
