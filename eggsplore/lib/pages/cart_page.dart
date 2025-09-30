import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcode data produk
    final List<Map<String, dynamic>> cartItems = [
      {
        "shop": "Claudiva Official",
        "name": "Capybara Import",
        "price": "Rp 999.999.999",
        "image": "assets/images/capy.jpeg",
      },
      {
        "shop": "Claudiva Official",
        "name": "Capybara Import",
        "price": "Rp 999.999.999",
        "image": "assets/images/capy.jpeg",
      },
      {
        "shop": "Claudiva Official",
        "name": "Capybara Import",
        "price": "Rp 999.999.999",
        "image": "assets/images/capy.jpeg",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // balik ke home page
          },
        ),
        title: Text(
          "My Cart (${cartItems.length})", // jumlah otomatis
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        backgroundColor: const Color(0xFFDADADA),
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Checkbox
                        Column(
                          children: [
                            Checkbox(
                              value: false,
                              onChanged: (val) {},
                            ),
                          ],
                        ),
                        const SizedBox(width: 4),
                        // Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Shop name + edit
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item["shop"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      "Edit",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item["image"],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  // Info produk
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item["name"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        // Quantity selector
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.remove,
                                                  size: 18),
                                            ),
                                            const Text("1"),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.add,
                                                  size: 18),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          item["price"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Bottom bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Checkbox(value: false, onChanged: (val) {}),
                const Text("All"),
                const Spacer(),
                const Text(
                  "Rp999.999.999",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                  ),
                  child: const Text(
                    "Checkout (1)",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
