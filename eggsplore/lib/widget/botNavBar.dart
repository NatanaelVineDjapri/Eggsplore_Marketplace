import 'package:flutter/material.dart';
import 'package:eggsplore/pages/home_page.dart';
import 'package:eggsplore/pages/cart_page.dart';
import 'package:eggsplore/pages/trending_page.dart';
import 'package:eggsplore/pages/notification_page.dart';
import 'package:eggsplore/pages/profile_page.dart';

class Botnavbar extends StatefulWidget {
  const Botnavbar({super.key});

  @override
  State<Botnavbar> createState() => _BotnavbarState();
}

class _BotnavbarState extends State<Botnavbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TrendingPage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NotificationPage()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30, color: Colors.orangeAccent),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined,
                size: 30, color: Colors.orangeAccent),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_outlined,
                size: 30, color: Colors.deepOrangeAccent),
            label: "Trending",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_sharp,
                size: 30, color: Colors.deepOrange),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded,
                size: 30, color: Colors.deepOrangeAccent),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
