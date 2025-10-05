import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/model/shop.dart';
import 'package:eggsplore/service/shop_service.dart';
import 'package:eggsplore/pages/myShop/modify_shop_info.dart';
import 'package:eggsplore/widget/shop_actions_card.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/widget/shop_info_card.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/pages/provider/product_provider.dart';
import 'package:eggsplore/widget/my_product_card.dart';

class MyShopPage extends ConsumerStatefulWidget {
  const MyShopPage({super.key});

  @override
  ConsumerState<MyShopPage> createState() => _MyShopPageState();
}

class _MyShopPageState extends ConsumerState<MyShopPage> {
  Shop? _myShop;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMyShopData();
  }

  Future<void> _fetchMyShopData() async {
    Shop? shop = await ShopService.getMyShop();
    if (mounted) {
      setState(() {
        _myShop = shop;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = Appsized(context);
    final myProductsAsync = ref.watch(myProductsProvider);

    return Scaffold(
      appBar: const backBar(title: "My Shop"),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFAE11),
          image: DecorationImage(
            image: AssetImage(AppImages.shopPattern),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeatY,
            alignment: Alignment.topCenter,
          ),
        ),
        child: _buildShopContent(myProductsAsync, size),
      ),
    );
  }

  Widget _buildShopContent(AsyncValue myProductsAsync, Appsized size) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    if (_myShop == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Anda belum memiliki toko.", style: AppTextStyle.mainTitle2),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange,
              ),
              child: const Text("Buat Toko Sekarang"),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchMyShopData,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShopInfoCard(
                    shopName: _myShop!.name,
                    description: _myShop!.description,
                    imagePath: _myShop!.image,
                    followers: "120",
                    buyers: "85",
                    rating: "4.8",
                    onModify: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ModifyShopInfoPage(),
                        ),
                      ).then((_) => _fetchMyShopData());
                    },
                  ),
                  const SizedBox(height: 20),
                  const ShopActionsCard(),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      AppStrings.myProducts,
                      style: AppTextStyle.mainTitle2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),

                  myProductsAsync.when(
                    data: (products) {
                      if (products.isEmpty) {
                        return SizedBox(
                          height: constraints.maxHeight * 0.4,
                          child: const Center(
                            child: Text(
                              "Belum ada produk.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return MyProductCard(
                            productId: product.id,
                            name: product.name,
                            price: product.price,
                            image: product.image,
                          );
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (err, stack) => Center(
                      child: Text("Error: $err"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}