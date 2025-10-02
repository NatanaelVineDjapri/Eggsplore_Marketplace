import 'package:flutter/material.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/bar/bottom_nav.dart'; 

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: Text(
          AppStrings.notificationHeader,
          style: AppTextStyle.notificationHeader,
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 🔹 Background notif_bg full
          Positioned.fill(
            child: Image.asset(
              AppImages.notif_bg,
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Konten utama
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // 🔹 Garis kuning full mentok kiri–kanan
              Container(
                height: 6,
                width: double.infinity,
                color: Colors.orange,
              ),
            ],
          ),
        ],
      ),  
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),    
    );
  }
}
