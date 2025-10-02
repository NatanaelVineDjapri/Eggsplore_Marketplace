import 'package:flutter/material.dart';
import 'package:eggsplore/app_routes.dart';

class ProfileShopTransitionPage extends StatelessWidget {
  const ProfileShopTransitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konfirmasi Toko"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.storefront, size: 80, color: Colors.orange),
              const SizedBox(height: 20),
              const Text(
                "Apakah kamu ingin membuka halaman toko?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Jika setuju, arahkan ke shop page
                      Navigator.pushReplacementNamed(context, AppRoutes.myshop);
                    },
                    child: const Text("Ya, lanjut"),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.orange),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Jika batal, kembali ke profile page
                      Navigator.pop(context);
                    },
                    child: const Text("Tidak"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
