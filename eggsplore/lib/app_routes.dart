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
import 'package:eggsplore/pages/notification_page.dart';
import 'package:eggsplore/pages/profile_shop_transition.dart';
import 'package:eggsplore/pages/product_page.dart';
import 'package:eggsplore/pages/shop_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/pages/cart_page.dart';

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
  static const String cart = '/cart';
  static const String trending = '/trending';
  static const String search = '/search';
  static const String shopresult = '/shopresult';
  static const String notifications = '/notifications';
  static const String profileShopTransition = '/profile-shop-transition';
  static const String product = '/product';
  static const String shopProfile = '/shop-profile';

<<<<<<< HEAD

=======
>>>>>>> e2f4d98b06d2db56e3f7915a9b3b1dde66c9a406
  static Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    changepassword: (context) => const ChangePasswordPage(),
    newpassword: (context) => const NewPasswordPage(),
    homepage: (context) => const HomePage(),
    myshop: (context) => const MyShopPage(),
    addProduct: (context) => const AddProductPage(),
    shopOrders: (context) => const ShopOrdersPage(),
    completedOrders: (context) => const CompletedOrdersPage(),
    profile: (context) => const ProfilePage(),
    cart: (context) => const CartPage(),
    trending: (context) => const TrendingPage(),
    profileShopTransition: (context) => const ProfileShopTransitionPage(),
    shopresult: (context) => const ShopResultPage(query: ""),
    notifications: (context) => const NotificationsPage(),
    search: (context) => const SearchPage(query: ""),
    product: (context) => const ProductPage(),
    shopProfile: (context) => const ShopProfilePage(),
  };
}
