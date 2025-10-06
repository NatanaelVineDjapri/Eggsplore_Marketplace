import 'package:eggsplore/constants/text_string.dart';
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
import '../provider/product_provider.dart';
import '../model/product.dart';
import '../widget/detail_product/topbar.dart';
import '../widget/detail_product/follow_button.dart';
import '../widget/detail_product/product_rating.dart';
import '../widget/detail_product/product_stock.dart';
import '../widget/expandable_description.dart';
import '../widget/review_tile.dart';

// --- MODIFIKASI ---
// Tambahkan import untuk halaman profil toko
// Sesuaikan path-nya jika perlu
import 'shop_profile_page.dart';

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
        error: (err, stack) => Center(child: Text('${AppStrings.failproductload} $err')),
        data: (product) {
          // Asumsi object 'product' memiliki properti 'shopImage'
          // Jika tidak, sesuaikan dengan nama properti yang benar
          final String shopImageUrl = ImageHelper.getImageUrl(product.shopImage ?? '');

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
                        '${AppStrings.pricerp} ${formatter.format(product.price)}',
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
                        AppStrings.proddesc,
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

                      // --- MODIFIKASI DIMULAI DI SINI ---
                      // Area info toko sekarang dibungkus dengan GestureDetector
                      GestureDetector(
                        onTap: () {
                          // Aksi ini akan dijalankan saat area info toko diklik
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              // Asumsi object 'product' punya properti 'shopId'
                              builder: (context) => ShopProfilePage(shopId: product.shopId),
                            ),
                          );
                        },
                        child: Container(
                          // Container ini memastikan seluruh area baris bisa diklik
                          color: Colors.transparent,
                          child: Row(
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
                                  // Asumsi object 'product' punya 'userName' sebagai nama toko
                                  Text(
                                    product.userName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    AppStrings.dmdesc,
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
                        ),
                      ),
                      // --- MODIFIKASI SELESAI DI SINI ---
                      
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
    // Asumsi ada 'reviewsProvider'
    final reviewsAsync = ref.watch(reviewsProvider(productId));
    return reviewsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (err, stack) => const SizedBox.shrink(),
      data: (reviews) {
        if (reviews.isEmpty) {
          return const Center(child: Text(AppStrings.dmnoreview));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.buyerrev,
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
                    child: const Text(AppStrings.seeallrev),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}