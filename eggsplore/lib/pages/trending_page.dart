import 'package:eggsplore/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/widget/trending_product_card.dart';
import 'package:eggsplore/widget/TopNavBar.dart';
import 'package:eggsplore/pages/search_page.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  final List<Map<String, String>> products = [
    {
      "name": "Telur 1kg",
      "price": "Rp. 25.000",
      "image": "assets/images/eggs.jpg",
    },
    {
      "name": "Ayam Potong 1 Ekor",
      "price": "Rp. 40.000",
      "image": "assets/images/chicken.jpg",
    },
    {
      "name": "Cabai 500gr",
      "price": "Rp. 30.000",
      "image": "assets/images/chili.jpg",
    },
    {
      "name": "ZGMF-X10A Freedom Gundam",
      "price": "Rp. 1.500.000",
      "image": "assets/images/gundam.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: AppColors.primary)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopNavBar(
                    onChatTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Chat tapped!")),
                      );
                    },
                    onSearch: (value) {
                      final query = value.trim();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SearchPage(query: query),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),
                  Center(
                    child: Image.asset(
                      "assets/images/trending.png",
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return TrendingProductCard(
                          name: product["name"]!,
                          price: product["price"]!,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}
