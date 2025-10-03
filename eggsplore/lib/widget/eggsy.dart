import 'package:flutter/material.dart';

class Eggsy extends StatelessWidget {
  final String imagePath;
  final double width;
  final double top;

  const Eggsy({
    super.key,
    required this.imagePath,
    this.width = 0.7,
    this.top = 0.05,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * top),
        child: Image.asset(imagePath, width: screenWidth * width),
      ),
    );
  }
}
