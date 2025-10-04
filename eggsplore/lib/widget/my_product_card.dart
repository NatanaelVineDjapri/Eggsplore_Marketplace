// File: widget/my_product_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/provider/product_provider.dart';
import 'package:eggsplore/service/product_service.dart';
import 'package:intl/intl.dart';

class MyProductCard extends ConsumerWidget {
  final int productId;
  final String name;
  final double price;
  final String? image;

  const MyProductCard({
    super.key,
    required this.productId,
    required this.name,
    required this.price,
    this.image,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizes = Appsized(context);
    final formatter = NumberFormat('#,###');
    final cardWidth = MediaQuery.of(context).size.width * 0.45;
    final imageUrl = image; 

    return SizedBox(
      width: cardWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(sizes.md),
            ),
            clipBehavior: Clip.antiAlias,
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 1.3,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: imageUrl != null && imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: Appsized.iconSm,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : Center(
                              child: Icon(
                                Icons.image,
                                size: Appsized.iconLg,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      sizes.md,
                      sizes.md,
                      sizes.sm,
                      sizes.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: Appsized.fontMd,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: sizes.xs),
                        Text(
                          "Rp ${formatter.format(price)}",
                          style: const TextStyle(
                            fontSize: Appsized.fontMd,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: -5,
            bottom: 15,
            child: GestureDetector(
              onTap: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Hapus Produk"),
                    content: const Text("Apakah Anda yakin ingin menghapus produk ini?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("Batal"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("Hapus"),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  try {
                    await ProductService.deleteProduct(productId);
                    ref.invalidate(myProductsProvider);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Produk berhasil dihapus!')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal menghapus produk: $e')),
                    );
                  }
                }
              },
              child: Container(
                width: sizes.lg,
                height: sizes.lg,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: Appsized.iconMd,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}