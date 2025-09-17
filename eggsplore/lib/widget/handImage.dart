import 'package:eggsplore/constants/images.dart';
import 'package:flutter/material.dart';

class Handimage extends StatelessWidget {
  final bool isLeft;
  const Handimage({
    super.key,
    required this.isLeft,
    required
    });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    if (isKeyboardVisible) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: screenHeight*0.245,
      left: isLeft ? screenWidth*0.63 : null,
      right: isLeft ? null : screenWidth*0.63,
      child: Center(child: Image.asset(AppImages.hand, width: 90)),
    );
  }
}
