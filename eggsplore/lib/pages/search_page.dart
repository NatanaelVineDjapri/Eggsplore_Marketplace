import 'package:flutter/material.dart';
import 'package:eggsplore/pages/product_result_page.dart';
import 'package:eggsplore/pages/shop_result_page.dart';
import 'package:eggsplore/widget/TopNavBar.dart';
import 'package:eggsplore/pages/chat_page.dart';
import 'package:eggsplore/constants/colors.dart';

class SearchPage extends StatelessWidget {
  final String query;

  const SearchPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.bleki),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: TopNavBar(
                        onChatTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatPage()),
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
                  ],
                ),
              ),
              Container(
                color: AppColors.primary,
                child: const TabBar(
                  indicatorColor: AppColors.white,
                  indicatorWeight: 3,
                  labelColor: AppColors.white,
                  unselectedLabelColor: AppColors.bleki,
                  tabs: [
                    Tab(text: "product"),
                    Tab(text: "shop"),
                  ],
                ),
              ),
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
