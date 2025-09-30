import 'package:eggsplore/pages/auth/change_password_page.dart';
import 'package:eggsplore/pages/auth/input_new_pass_page.dart';
import 'package:eggsplore/pages/auth/login_page.dart';
import 'package:eggsplore/pages/auth/register_page.dart';
import 'package:eggsplore/pages/auth/welcome_page.dart';
import 'package:eggsplore/pages/home_page.dart';
import 'package:eggsplore/pages/myShop/my_shop_page.dart';
import 'package:eggsplore/pages/myShop/add_product_page.dart';
import 'package:eggsplore/pages/myShop/shop_orders_page.dart';
import 'package:eggsplore/pages/myShop/completed_orders_page.dart';
import 'package:eggsplore/pages/profile_page.dart';
import 'package:eggsplore/pages/trending_page.dart';
import 'package:eggsplore/pages/search_page.dart';
import 'package:eggsplore/pages/shop_result_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String changepassword = '/change-password';
  static const String newpassword = '/new-password';
  static const String homepage = '/homepage';
  static const String myshop = '/myshop';
  static const String addProduct = '/add-product';
  static const String shopOrders = '/shop-orders';
  static const String completedOrders = '/completed-orders';
  static const String profile = '/profile';
  static const String trending = '/trending';
  static const String search = '/search';
  static const String shopresult = '/shopresult';

  static Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    changepassword: (context) => const ChangePassword(),
    newpassword: (context) => const NewPasswordPage(),
    homepage: (context) => const HomePage(),
    myshop: (context) => const MyShopPage(),
    addProduct: (context) => const AddProductPage(),
    shopOrders: (context) => const ShopOrdersPage(),
    completedOrders: (context) => const CompletedOrdersPage(),
    profile: (context) => const ProfilePage(),
    trending: (context) => const TrendingPage(),
    shopresult: (context) => const ShopResultPage(query: ""),

    // ✅ kasih default query kosong biar ga error
    search: (context) => const SearchPage(query: ""),
  };
}
