import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/constants/colors.dart';

class CompletedOrdersPage extends StatefulWidget {
  const CompletedOrdersPage({super.key});

  @override
  State<CompletedOrdersPage> createState() => _CompletedOrdersPageState();
}

class _CompletedOrdersPageState extends State<CompletedOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      appBar: backBar(title: "Completed Orders"),
      body: Center(
        child: Text(
          "Completed Orders Page (Empty)",
          style: TextStyle(color: AppColors.white, fontSize: 18),
        ),
      ),
    );
  }
}
