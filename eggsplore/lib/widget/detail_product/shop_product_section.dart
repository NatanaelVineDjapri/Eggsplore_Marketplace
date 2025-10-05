import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/pages/provider/product_provider.dart';
import 'package:eggsplore/widget/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/shop_products_args.dart'; // SESUAIKAN PATH INI!

class ShopProductsSection extends ConsumerWidget {
  final int shopId;
  final int currentProductId;

  const ShopProductsSection({
    super.key,
    required this.shopId,
    required this.currentProductId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopProductsAsync = ref.watch(
      productsFromShopProvider(
        ShopProductsArgs(shopId: shopId, excludeProductId: currentProductId),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Lainnya di toko ini",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        // Jarak dikurangi dari 16 menjadi 8
        const SizedBox(height: 8),
        shopProductsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Gagal memuat produk toko: $err'),
          data: (products) {
            if (products.isEmpty) {
              return const Text("Tidak ada produk lain di toko ini.");
            }

            return GridView.builder(
              shrinkWrap: true,
              primary: false,

              scrollDirection: Axis.vertical,
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 1.0,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final shopProduct = products[index];
                return ProductCard(
                  productId: shopProduct.id,
                  name: shopProduct.name,
                  price: shopProduct.price,
                  image: shopProduct.image,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
