import 'package:flutter/material.dart';

class ProductTrackingPage extends StatelessWidget {
  final String productImage;
  final String productName;
  final int quantity;
  final int price;
  final String seller;
  final String courier;
  final List<Map<String, String>> tracking;

  const ProductTrackingPage({
    super.key,
    required this.productImage,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.seller,
    required this.courier,
    required this.tracking,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Dikirim"),
        centerTitle: true,
        backgroundColor: Colors.grey.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar Produk
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        productImage,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(productName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text("Kuantitas: $quantity"),
                          const SizedBox(height: 4),
                          Text("Rp. ${price.toString()}"),
                          const SizedBox(height: 8),
                          Text("Pengirim : $seller"),
                          Text("Kurir : $courier"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: tracking.map((item) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const Icon(Icons.circle, size: 12, color: Colors.yellow),
                            Container(
                              height: 30,
                              width: 2,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${item['time']} ${item['date']}",
                                  style: const TextStyle(fontSize: 12)),
                              Text(item['status'] ?? "",
                                  style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}