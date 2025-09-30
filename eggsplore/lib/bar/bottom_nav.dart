import 'package:flutter/material.dart';
import 'package:eggsplore/app_routes.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.homepage);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.cart);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.homepage);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, AppRoutes.homepage);
        break;
      case 4:
        Navigator.pushReplacementNamed(context, AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // biar semua icon keliatan
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
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
    );
  }
}
