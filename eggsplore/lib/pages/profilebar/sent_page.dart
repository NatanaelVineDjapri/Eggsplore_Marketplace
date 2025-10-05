import 'package:flutter/material.dart';
import 'package:eggsplore/widget/proiflebar/sentprogress.dart';

class SentPage extends StatelessWidget {
  const SentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesanan Dikirim"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text(
                "Belum ada pesanan",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  leading: Image.network(
                    order["productImage"] as String,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(order["productName"] as String),
                  subtitle: Text("Rp ${order["price"]}"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductTrackingPage(
                          productImage: order["productImage"] as String,
                          productName: order["productName"] as String,
                          quantity: order["quantity"] as int,
                          price: order["price"] as int,
                          seller: order["seller"] as String,
                          courier: order["courier"] as String,
                          tracking: List<Map<String, String>>.from(
                            order["tracking"] as List,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}