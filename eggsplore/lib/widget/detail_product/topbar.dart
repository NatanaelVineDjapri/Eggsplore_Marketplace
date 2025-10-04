import 'package:flutter/material.dart';
import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/pages/search/search_page.dart';
import 'package:eggsplore/pages/chat_page.dart';
import 'package:eggsplore/pages/cart_page.dart';
import 'package:eggsplore/constants/colors.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchPage(query: ""),
            ),
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline, color: AppColors.white),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.chat);
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.white),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.cart);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
