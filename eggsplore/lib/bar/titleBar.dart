import 'package:flutter/material.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/constants/colors.dart';

class titleBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const titleBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      automaticallyImplyLeading: false,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title.toUpperCase(),
          style: AppTextStyle.mainTitle.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
