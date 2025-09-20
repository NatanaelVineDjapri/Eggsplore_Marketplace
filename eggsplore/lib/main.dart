import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/pages/auth/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/pages/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.myshop,
      routes: AppRoutes.routes,
    );
  }
}