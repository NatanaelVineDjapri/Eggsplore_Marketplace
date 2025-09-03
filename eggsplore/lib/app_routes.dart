import 'package:eggsplore/pages/auth/login_page.dart';
import 'package:eggsplore/pages/auth/register_page.dart';
import 'package:eggsplore/pages/auth/welcome_page.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String register = '/register';

  static Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
  };
}
