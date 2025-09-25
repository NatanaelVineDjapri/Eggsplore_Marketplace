import 'package:flutter/material.dart';
import 'package:eggsplore/pages/home_page.dart';
import 'package:eggsplore/widget/chat/chat_item.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Chat",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),                                                                                                
      ),
      body: ListView(
        children: const [
          ChatItem(name: "Frayz94", date: "Yesterday"),
          ChatItem(name: "de(mon)vin", date: "19 Apr"),
          ChatItem(name: "dihyo", date: "17 Apr"),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 28),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up, size: 28),
            label: "Trending",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, size: 28),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
