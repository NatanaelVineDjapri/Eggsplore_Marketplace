import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/pages/profile/order_detail_page.dart';

class OnProcessPage extends StatelessWidget {
  const OnProcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = [
      {
        "username": "ElectronJKT",
        "productName": "Charger Laptop Lenovo LOQ 15",
        "quantity": 1,
        "price": 470000,
        "image": AppImages.charger,
      },
      {
        "username": "MilNgemil.ID",
        "productName": "Makaroni Mercon 1kg",
        "quantity": 10,
        "price": 15000,
        "image": AppImages.makaroni,
      },
      {
        "username": "Optik Melambai",
        "productName": "Frame Kacamata Molsion F MP",
        "quantity": 1,
        "price": 1200000,
        "image": AppImages.kacamata,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFAE11),
      appBar: backBar(title: "On Process"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderDetailPage(order: order),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            order["image"] as String,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order["username"] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${order["productName"]} x ${order["quantity"]}",
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Total: Rp ${order["price"]}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
