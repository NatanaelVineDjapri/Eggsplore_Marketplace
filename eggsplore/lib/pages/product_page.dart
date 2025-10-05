import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/constants/sizes.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Appsized(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            onPressed: () {}, // ke chat toko nanti
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {}, // ke cart nanti
          ),
        ],
      ),
      body: ListView(
        children: [
          // Gambar Produk
          Container(
            height: size.height * 0.3,
            color: Colors.grey[300],
            child: const Center(
              child: Text(AppStrings.prodimage,
                  style: TextStyle(color: Colors.black54)),
            ),
          ),

          // Info Produk
          Padding(
            padding: EdgeInsets.all(size.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(AppStrings.onemil,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text(AppStrings.onekgchili,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.black87, size: 18),
                        SizedBox(width: 4),
                        Text(AppStrings.ratedummy),
                      ],
                    ),
                    Text(AppStrings.stock),
                  ],
                ),
              ],
            ),
          ),

          // 🔶 Divider Kuning
          Container(
            height: 2,
            color: Colors.orange,
            margin: EdgeInsets.symmetric(vertical: size.sm),
          ),

          // Review Section
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: size.md, vertical: size.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(AppStrings.review,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(AppStrings.seeall, style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(AppStrings.userdummy,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: const [
                    Icon(Icons.star, size: 18, color: Colors.black87),
                    SizedBox(width: 4),
                    Text(AppStrings.givingrate),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(AppStrings.commentreview),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: EdgeInsets.only(right: size.sm),
                      width: 60,
                      height: 60,
                      color: Colors.grey[300],
                      child: const Center(child: Text(AppStrings.img)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(thickness: 1, color: Colors.grey[300]),

          // Toko Section
          Padding(
            padding: EdgeInsets.all(size.md),
            child: Container(
              padding: EdgeInsets.all(size.md),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.store, color: Colors.white, size: 30),
                  ),
                  SizedBox(width: size.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(AppStrings.soychicken,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Text(AppStrings.westjakarta,
                            style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    child: const Text(AppStrings.followtext),
                  ),
                ],
              ),
            ),
          ),

          // 🔶 Divider Kuning bawah deskripsi
          Container(
            height: 2,
            color: Colors.orange,
            margin: EdgeInsets.symmetric(vertical: size.sm),
          ),

          // Deskripsi
          Padding(
            padding: EdgeInsets.all(size.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(AppStrings.proddesct,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 8),
                Text(AppStrings.eurochili),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
