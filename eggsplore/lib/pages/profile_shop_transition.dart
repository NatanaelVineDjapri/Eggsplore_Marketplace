import 'package:flutter/material.dart';
import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/bar/backBar2.dart';
import 'package:eggsplore/constants/colors.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/constants/text_style.dart';

class ProfileShopTransitionPage extends StatelessWidget {
  const ProfileShopTransitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar2(title: AppStrings.confirmShopTitle),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.storefront, size: 80, color: AppColors.primary),
              const SizedBox(height: 20),
              Text(
                AppStrings.confirmShopQuestion,
                textAlign: TextAlign.center,
                style: AppTextStyle.subtitle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.myshop);
                    },
                    child: Text(
                      AppStrings.confirmShopYes,
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppStrings.confirmShopNo,
                      style: const TextStyle(color: AppColors.primary),
                    ),
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
