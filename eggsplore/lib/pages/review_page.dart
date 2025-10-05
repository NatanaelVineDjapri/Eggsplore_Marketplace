import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/helper/image_helper.dart';
import 'package:eggsplore/model/review.dart';
import 'package:eggsplore/pages/provider/product_provider.dart';
import 'package:eggsplore/widget/detail_product/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllReviewsPage extends ConsumerWidget {
  final int productId;
  const AllReviewsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(reviewsProvider(productId));

    return Scaffold(
      appBar: const TopBar(title: AppStrings.productreview),
      body: reviewsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
        data: (reviews) {
          if (reviews.isEmpty) {
            return const Center(child: Text(AppStrings.noreviewproduct));
          }
          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return _ReviewTile(review: reviews[index]);
            },
          );
        },
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final Review review;
  const _ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = ImageHelper.getImageUrl(review.userAvatar);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl)
                    : null,
                child: imageUrl.isEmpty ? const Icon(Icons.person) : null,
              ),
              const SizedBox(width: 12),
              Text(review.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < review.rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              );
            }),
          ),
          if (review.comment != null && review.comment!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(review.comment!, style: TextStyle(color: Colors.grey.shade800)),
            ),
        ],
      ),
    );
  }
}