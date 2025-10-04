import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/images.dart';

class SentPage extends StatelessWidget {
  const SentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = {
      "username": "BekasiFarmHouse",
      "productName": "Kuda Poni",
      "quantity": 1,
      "price": 19400000,
      "image": AppImages.poni,
    };

    return Scaffold(
      backgroundColor: const Color(0xFFFFAE11),
      appBar: backBar(title: "Sent"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/delivery-tracking'),
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
          ],
        ),
      ),
    );
  }
}
