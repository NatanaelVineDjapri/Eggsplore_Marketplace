import 'package:flutter/material.dart';
import 'package:eggsplore/pages/product_result_page.dart';
import 'package:eggsplore/pages/shop_result_page.dart';
import 'package:eggsplore/widget/TopNavBar.dart';
import 'package:eggsplore/pages/chat_page.dart';

class SearchPage extends StatelessWidget {
  final String query;

  const SearchPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // 🔹 Top NavBar (sama kayak HomePage)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: TopNavBar(
                  onChatTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatPage()),
                    );
                  },
                  onSearch: (value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchPage(query: value),
                      ),
                    );
                  },
                ),
              ),

              // 🔹 Tab menu
              Container(
                color: Colors.orange,
                child: const TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 3,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black87,
                  tabs: [
                    Tab(text: "product"),
                    Tab(text: "shop"),
                  ],
                ),
              ),

              // 🔹 Konten tab
              Expanded(
                child: TabBarView(
                  children: [
                    ProductResultPage(query: query),
                    ShopResultPage(query: query),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
