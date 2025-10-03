import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/model/like_model.dart';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/provider/product_provider.dart';
import 'package:eggsplore/provider/like_provider.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:eggsplore/widget/product.dart';
import 'package:eggsplore/widget/profile/profile_actions_card.dart';
import 'package:eggsplore/widget/profile/profile_info_card.dart';
import 'package:eggsplore/widget/profile/profile_shop_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late Future<User?> userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = UserService.getCurrentUser();
  }

  String _getUsername(User user) => user.name;

  Widget buildSectionTitle(BuildContext context, String title, double fontSize, FontWeight fontWeight) {
    final size = Appsized(context);
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.sm),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.mainTitle2.copyWith(
              color: Colors.black87,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = Appsized(context);
    final randomProductsAsync = ref.watch(randomProductsProvider);
    final likedProductsAsync = ref.watch(likedProductsProvider);

    return Scaffold(
      body: Stack(
        children: [
          // HEADER IMAGE
          SizedBox(
            height: size.height * 0.41,
            width: double.infinity,
            child: Image.asset(
              AppImages.profileHeader,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          SafeArea(
            child: FutureBuilder<User?>(
              future: userFuture,
              builder: (context, userSnapshot) {
                final user = userSnapshot.data;
                final username = userSnapshot.hasData && user != null
                    ? _getUsername(user)
                    : (userSnapshot.connectionState == ConnectionState.waiting
                        ? 'Loading...'
                        : 'Pengguna');

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER TEXT & CARDS
                    Padding(
                      padding: EdgeInsets.fromLTRB(size.hmd, size.md, size.hmd, size.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Halo, $username',
                            style: AppTextStyle.mainTitle2.copyWith(
                              color: Colors.white,
                              fontSize: Appsized.fontxxl,
                            ),
                          ),
                          SizedBox(height: size.md),
                          Row(
                            children: [
                              ProfileInfoCard(user: user),
                              SizedBox(width: size.hsm),
                              const ProfileShopCard(),
                            ],
                          ),
                          SizedBox(height: size.md),
                          const ProfileActionsCard(),
                          SizedBox(height: size.xxxl),
                        ],
                      ),
                    ),

                    // WISHLIST & RECOMMENDATIONS
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: size.hmd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSectionTitle(context, "$username's Wishlist", Appsized.fontMd, FontWeight.bold),
                            SizedBox(height: size.md),
                            likedProductsAsync.when(
                              data: (likedProducts) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  final notifier = ref.read(likeStateProvider.notifier);
                                  for (var product in likedProducts) {
                                    if (!notifier.state.containsKey(product.id)) {
                                      notifier.state = {
                                        ...notifier.state,
                                        product.id: Like(productId: product.id, totalLikes: 0, userLiked: true),
                                      };
                                    }
                                  }
                                });

                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: likedProducts.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: size.sm,
                                    mainAxisSpacing: size.sm,
                                    childAspectRatio: 0.7,
                                  ),
                                  itemBuilder: (context, index) {
                                    final product = likedProducts[index];
                                    final isLiked = ref.watch(likeStateProvider)[product.id]?.userLiked ?? false;

                                    return ProductCard(
                                      productId: product.id,
                                      name: product.name,
                                      price: product.price,
                                      image: product.image,
                                      isLiked: isLiked,
                                    );
                                  },
                                );
                              },
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (err, stack) => Text("Error: $err"),
                            ),
                            SizedBox(height: size.xl),
                            buildSectionTitle(context, AppStrings.maybe, Appsized.fontSm, FontWeight.normal),
                            SizedBox(height: size.md),
                            randomProductsAsync.when(
                              data: (products) {
                                if (products.isEmpty) {
                                  return const Text("Tidak ada produk rekomendasi.", style: TextStyle(color: Colors.grey));
                                }
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: products.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: size.sm,
                                    mainAxisSpacing: size.sm,
                                    childAspectRatio: 0.7,
                                  ),
                                  itemBuilder: (context, index) {
                                    final product = products[index];
                                    final isLiked = ref.watch(likeStateProvider)[product.id]?.userLiked ?? false;

                                    return ProductCard(
                                      productId: product.id,
                                      name: product.name,
                                      price: product.price,
                                      image: product.image,
                                      isLiked: isLiked,
                                    );
                                  },
                                );
                              },
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (err, stack) => Text("Error: $err"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }
}
