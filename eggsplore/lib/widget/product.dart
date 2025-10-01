import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/provider/like_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  final int productId;
  final String name;
  final double price;
  final String? image;

  const ProductCard({
    super.key,
    required this.productId,
    required this.name,
    required this.price,
    this.image,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizes = Appsized(context);
    final formatter = NumberFormat('#,###', 'id_ID');
    
    final likeState = ref.watch(likeStateProvider);
    final likeNotifier = ref.read(likeStateProvider.notifier);
    final like = likeState[productId];

    final cardWidth = MediaQuery.of(context).size.width * 0.45;
    const addIconSize = Appsized.iconLg;
    final addContainerDimension = addIconSize + 12.0;

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
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: image != null && image!.isNotEmpty
                              ? Image.network(
                                  image!,
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
                        // Tombol like
                        Positioned(
                          top: sizes.xs,
                          left: sizes.xs,
                          child: GestureDetector(
                            onTap: () async {
                              await likeNotifier.toggleLike(productId);
                            },
                            child: Container(
                              width: Appsized.iconMd,
                              height: Appsized.iconMd,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  like?.userLiked ?? false
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: like?.userLiked ?? false
                                      ? Colors.red
                                      : Colors.black,
                                  size: Appsized.iconSm,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
          // Tombol add tetap di kanan bawah
          Positioned(
            right: -5,
            bottom: 15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(sizes.sm),
              child: Material(
                color: Colors.orange,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: addContainerDimension,
                    height: addContainerDimension,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: addIconSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
