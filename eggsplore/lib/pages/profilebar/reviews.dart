import 'package:flutter/material.dart';
import 'package:eggsplore/widget/proiflebar/review_list.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "ULASAN",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: const ReviewList(reviews: []),
    );
  }
}