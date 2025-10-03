import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/text_style.dart';

class ShopOrdersPage extends StatefulWidget {
  const ShopOrdersPage({super.key});

  @override
  State<ShopOrdersPage> createState() => _ShopOrdersPageState();
}

class _ShopOrdersPageState extends State<ShopOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFffae11),
      appBar: backBar(title: "Shop Orders"),
      body: Center(
        child: Text(
          "Shop Orders Page (Empty)",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
