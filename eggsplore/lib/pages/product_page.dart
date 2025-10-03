import 'package:eggsplore/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/constants/sizes.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Appsized(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: AppColors.white),
            onPressed: () {}, 
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.white),
            onPressed: () {}, 
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: size.height * 0.3,
            color: AppColors.grey[300],
            child: const Center(
              child: Text("Product Image",
                  style: TextStyle(color: AppColors.bleki)),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(size.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Rp 1.000.000",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("Cabe Rawit 1 Kg",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.bleki, size: 18),
                        SizedBox(width: 4),
                        Text("4.8 (20)"),
                      ],
                    ),
                    Text("stok : 9"),
                  ],
                ),
              ],
            ),
          ),

          Container(
            height: 2,
            color: AppColors.primary,
            margin: EdgeInsets.symmetric(vertical: size.sm),
          ),

          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: size.md, vertical: size.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Review",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("See all", style: TextStyle(color: AppColors.blu)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("claudival123",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: const [
                    Icon(Icons.star, size: 18, color: AppColors.bleki),
                    SizedBox(width: 4),
                    Text("3.1/5"),
                  ],
                ),
                const SizedBox(height: 4),
                const Text("mesennya kayak iklan, banyak dramanya"),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: EdgeInsets.only(right: size.sm),
                      width: 60,
                      height: 60,
                      color: AppColors.grey[300],
                      child: const Center(child: Text("Img")),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(thickness: 1, color: AppColors.grey[300]),

          Padding(
            padding: EdgeInsets.all(size.md),
            child: Container(
              padding: EdgeInsets.all(size.md),
              decoration: BoxDecoration(
                color: AppColors.primary[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.grey,
                    child: Icon(Icons.store, color: AppColors.white, size: 30),
                  ),
                  SizedBox(width: size.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Ayam Kecap",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Text("Jakarta Barat",
                            style: TextStyle(color: AppColors.bleki)),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.bleki),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    child: const Text("Follow"),
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 2,
            color: AppColors.primary,
            margin: EdgeInsets.symmetric(vertical: size.sm),
          ),

          Padding(
            padding: EdgeInsets.all(size.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Product Description",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 8),
                Text("Cabe belanda yang dibesarkan seperti anak sendiri"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
