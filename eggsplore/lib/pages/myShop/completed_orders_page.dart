import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/text_style.dart';

class CompletedOrdersPage extends StatefulWidget {
  const CompletedOrdersPage({super.key});

  @override
  State<CompletedOrdersPage> createState() => _CompletedOrdersPageState();
}

class _CompletedOrdersPageState extends State<CompletedOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFffae11),
      appBar: backBar(title: "Completed Orders"),
      body: Center(
        child: Text(
          "Completed Orders Page (Empty)",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
