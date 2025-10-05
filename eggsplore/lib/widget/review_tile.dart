import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/helper/image_helper.dart';
import 'package:flutter/material.dart';
import '../model/review.dart'; 

class ReviewTile extends StatelessWidget {
  final Review review;
  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final size = Appsized(context);
    final String imageUrl = ImageHelper.getImageUrl(review.userAvatar);
        print("Mencoba memuat gambar dari URL: $imageUrl");

    return Container(
      padding: EdgeInsets.fromLTRB(
          size.sm,
          size.md,  
          size.md, 
          size.md, 
        ),
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
                // child: imageUrl.isEmpty ? const Icon(Icons.person) : null,
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