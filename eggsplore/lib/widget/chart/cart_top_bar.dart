import 'package:flutter/material.dart';

class CartTopBar extends StatelessWidget implements PreferredSizeWidget {
  final Color primaryColor;

  const CartTopBar({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("Keranjang", style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0.5,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
