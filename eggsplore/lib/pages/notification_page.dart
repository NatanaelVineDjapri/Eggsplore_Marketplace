import 'package:flutter/material.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/bar/bottom_nav.dart';
import 'package:eggsplore/bar/titleBar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const titleBar(title: AppStrings.notificationHeader),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.notif_bg,
              fit: BoxFit.cover,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.voucher1,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        AppImages.voucher2,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        AppImages.voucher3,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
}
