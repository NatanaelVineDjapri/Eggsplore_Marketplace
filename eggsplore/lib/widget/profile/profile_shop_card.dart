import 'package:flutter/material.dart';
import 'package:eggsplore/app_routes.dart';

class ProfileShopCard extends StatefulWidget {
  const ProfileShopCard({super.key});

  @override
  State<ProfileShopCard> createState() => _ProfileShopCardState();
}

class _ProfileShopCardState extends State<ProfileShopCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.profileShopTransition);
        },
        child: Container(
          height: 100, // disamain dengan ProfileInfoCard
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.storefront, // 🔹 simbol toko
                size: 32,
                color: Colors.orange, // bisa diubah sesuai tema
              ),
              SizedBox(width: 10),
              Text(
                "My Shop",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}