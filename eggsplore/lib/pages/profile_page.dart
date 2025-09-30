import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/service/product_service.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:eggsplore/widget/product.dart';
import 'package:eggsplore/widget/profile/profile_actions_card.dart';
import 'package:eggsplore/widget/profile/profile_info_card.dart';
import 'package:eggsplore/widget/profile/profile_shop_card.dart';
import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User?> userFuture;
  late Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();
    userFuture = UserService.getCurrentUser();
    productsFuture = ProductService.fetchRandomProductsForCurrentUser();
  }

  String _getUsername(User user) {
    return user.name ?? 'Pengguna';
  }

  @override
  Widget build(BuildContext context) {
    final size = Appsized(context);

    return Scaffold(
      body: Stack(
        children: [
          // HEADER BACKGROUND
          Container(
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
                    // HEADER (non-scrollable)
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        size.hmd,
                        size.md,
                        size.hmd,
                        size.md,
                      ),
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
                          // Text di tengah
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1, // ketebalan garis
                                  endIndent: 10, // jarak ke teks
                                ),
                              ),
                              Text(
                                AppStrings.maybe,
                                style: AppTextStyle.mainTitle2.copyWith(
                                  color: Colors.black87,
                                  fontSize: Appsized.fontSm,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                  indent: 10, // jarak ke teks
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: size.sm),
                        ],
                      ),
                    ),

                    // GRID PRODUK (scrollable)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.hmd),
                        child: FutureBuilder<List<Product>>(
                          future: productsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.hasError ||
                                !snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                  "Tidak ada produk rekomendasi.",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }

                            final products = snapshot.data!;

                            return GridView.builder(
                              padding: EdgeInsets.only(
                                bottom: size.lg,
                                left: size.xs,
                                right: size
                                    .xs, // ← ini biar card nggak nempel ke tepi
                              ),
                              itemCount: products.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: size.sm,
                                    mainAxisSpacing: size.sm,
                                    childAspectRatio:
                                        0.7, // sama seperti HomePage
                                  ),
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return ProductCard(
                                  name: product.name,
                                  price: product.price,
                                  image: product.image,
                                );
                              },
                            );
                          },
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
