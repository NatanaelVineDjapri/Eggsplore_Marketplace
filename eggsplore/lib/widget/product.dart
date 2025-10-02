import 'package:eggsplore/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String? image;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = Appsized(context);
    final formatter = NumberFormat('#,###');

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
                        Positioned(
                          top: sizes.xs,
                          left: sizes.xs,
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
                                Icons.favorite_border,
                                color: Colors.black,
                                size: Appsized.iconSm,
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
          
          Positioned(
            right: -5,
            bottom: 15,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(sizes.sm),
                topRight: Radius.circular(sizes.sm),
                bottomRight: Radius.circular(sizes.sm),
                bottomLeft: Radius.circular(sizes.sm),
              ),
              child: Material(
                color: Colors.orange,
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
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