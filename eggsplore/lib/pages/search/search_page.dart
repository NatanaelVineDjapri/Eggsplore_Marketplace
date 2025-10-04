import 'package:flutter/material.dart';
import 'package:eggsplore/pages/search/product_result_page.dart';
import 'package:eggsplore/pages/search/shop_result_page.dart';
import 'package:eggsplore/widget/TopNavBar.dart';
import 'package:eggsplore/pages/chat_page.dart';
import 'package:eggsplore/constants/colors.dart';

class SearchPage extends StatelessWidget {
  final String query;
  final int initialIndex;

  const SearchPage({super.key, required this.query, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.bleki,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Builder(
                        // <-- Tambahin Builder biar context nya dapet DefaultTabController
                        builder: (innerContext) {
                          return TopNavBar(
                            onChatTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChatPage(),
                                ),
                              );
                            },
                            onSearch: (value) {
                              final tabIndex = DefaultTabController.of(
                                innerContext,
                              ).index; // ✅ pake innerContext
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SearchPage(
                                    query: value,
                                    initialIndex: tabIndex,
                                  ),
                                ),
                              );
                            },
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
                    Tab(text: "Product"),
                    Tab(text: "Shop"),
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
