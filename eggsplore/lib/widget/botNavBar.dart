import 'package:flutter/material.dart';

class Botnavbar extends StatelessWidget {
  const Botnavbar({super.key});

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
                color: Colors.orangeAccent,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color: Colors.orangeAccent,
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.local_fire_department_outlined,
                size: 30,
                color: Colors.deepOrangeAccent,
            ),
            label: "Trending",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_none_sharp,
                size: 30,
                color: Colors.deepOrange,
            ),
            label: "Notification",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_rounded,
                size: 30,
                color: Colors.deepOrangeAccent,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}