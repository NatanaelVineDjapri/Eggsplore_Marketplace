import 'package:eggsplore/pages/auth/change_password_page.dart';
import 'package:eggsplore/pages/auth/input_new_pass_page.dart';
import 'package:eggsplore/pages/auth/login_page.dart';
import 'package:eggsplore/pages/auth/register_page.dart';
import 'package:eggsplore/pages/auth/welcome_page.dart';
import 'package:eggsplore/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String changepassword = '/change-password';
  static const String newpassword = '/new-password';
  static const String homepage = '/homepage';

  static Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    changepassword: (context) => const ChangePassword(),
    newpassword: (context) => const NewPasswordPage(),
    homepage: (context) => const HomePage(),
  };
}
