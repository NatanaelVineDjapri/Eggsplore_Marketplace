import 'package:eggsplore/helper/image_helper.dart';
import 'package:eggsplore/pages/review_page.dart';
import 'package:eggsplore/widget/detail_product/add_to_cart_button2.dart';
import 'package:eggsplore/widget/detail_product/buy_now_button.dart';
import 'package:eggsplore/widget/detail_product/chat_button_product.dart';
import 'package:eggsplore/widget/detail_product/shop_product_section.dart';
import 'package:eggsplore/widget/product.dart';
import 'package:eggsplore/widget/random_product_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:eggsplore/constants/colors.dart';
import 'provider/product_provider.dart';
import '../model/product.dart';
import '../widget/detail_product/topbar.dart';
import '../widget/detail_product/follow_button.dart';
import '../widget/detail_product/product_rating.dart';
import '../widget/detail_product/product_stock.dart';
import '../widget/expandable_description.dart';
import '../widget/review_tile.dart';

class DetailProductPage extends ConsumerWidget {
  final int productId;
  const DetailProductPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailProvider(productId));
    final formatter = NumberFormat('#,###', 'id_ID');

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const TopBar(title: "Detail Produk"),
      body: productAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (err, stack) => Center(child: Text("Gagal memuat produk: $err")),
        data: (product) {
          final String shopImageUrl = ImageHelper.getImageUrl(
            product.shopImage,
          );

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.grey[200],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.grey,
                              ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Rp ${formatter.format(product.price)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(
                        color: AppColors.primary,
                        thickness: 1,
                        height: 24,
                      ),
                      const Text(
                        "Deskripsi Produk",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ExpandableDescription(text: product.description),
                      const Divider(
                        color: AppColors.primary,
                        thickness: 1,
                        height: 24,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: shopImageUrl.isNotEmpty
                                ? NetworkImage(shopImageUrl)
                                : null,
                            child: shopImageUrl.isEmpty
                                ? const Icon(
                                    Icons.store,
                                    color: AppColors.white,
                                  )
                                : null,
                            backgroundColor: AppColors.primary,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.userName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Online 5 menit lalu",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          FollowButton(
                            isInitiallyFollowing: false,
                            onFollow: () => debugPrint("Followed toko"),
                            onUnfollow: () => debugPrint("Unfollowed toko"),
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppColors.primary,
                        thickness: 1,
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProductRating(averageRating: product.averageRating),
                          ProductStock(stock: product.stock),
                        ],
                      ),
                      const Divider(
                        color: AppColors.primary,
                        thickness: 1,
                        height: 24,
                      ),
                      _buildReviewsSummarySection(context, ref, product.id),
                      const SizedBox(height: 40),

                      ShopProductsSection(
                        shopId: product.shopId,
                        currentProductId: product.id,
                      ),

                      const SizedBox(height: 10),
                      const RandomProductsGrid(),
                    ],
                  ),
                ),
              ),
              _buildBottomNavBar(context, product, AppColors.primary),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomNavBar(
    BuildContext context,
    Product product,
    Color primaryColor,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            ChatButtonProduct(product: product, primaryColor: primaryColor),
            const SizedBox(width: 12),
            AddToCartButtonProduct(product: product, color: primaryColor),
            const SizedBox(width: 12),
            BuyNowButton(color: primaryColor, product: product),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSummarySection(
    BuildContext context,
    WidgetRef ref,
    int productId,
  ) {
    final reviewsAsync = ref.watch(reviewsProvider(productId));
    return reviewsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (err, stack) => const SizedBox.shrink(),
      data: (reviews) {
        if (reviews.isEmpty) {
          return const Center(child: Text("Belum ada ulasan."));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ulasan Pembeli",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...reviews
                .take(3)
                .map((review) => ReviewTile(review: review))
                .toList(),
            if (reviews.length > 3)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AllReviewsPage(productId: productId),
                        ),
                      );
                    },
                    child: const Text("Lihat Semua Ulasan"),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
