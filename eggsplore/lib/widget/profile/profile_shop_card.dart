import 'package:flutter/material.dart';
import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/constants/colors.dart';

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
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.bleki.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.storefront,
                size: 32,
                color: AppColors.primary,
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
