import 'package:flutter/material.dart';

class ReviewModel {
  final String imageUrl;
  final String title;
  final int quantity;
  final String price;
  final bool showButton;
  final bool showStars;

  ReviewModel({
    required this.imageUrl,
    required this.title,
    required this.quantity,
    required this.price,
    this.showButton = false,
    this.showStars = false,
  });
}

class ReviewList extends StatelessWidget {
  final List<ReviewModel> reviews;

  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Center(
        child: Text(
          "Belum ada ulasan",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ReviewItem(review: review);
      },
    );
  }
}

class ReviewItem extends StatelessWidget {
  final ReviewModel review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                review.imageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Kuantitas : ${review.quantity}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    review.price,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),

                  if (review.showButton)
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                        ),
                        child: const Text(
                          "Beri Ulasan",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ),
                  if (review.showStars)
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star_border,
                          color: Colors.orange,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}