import 'package:flutter/material.dart';
import '../constants/sizes.dart';
import '../constants/text_string.dart';

class richTextTitle extends StatelessWidget {
  final String mainTitle;
  final String accentTitle;
  final double fontSize;
  final Color mainColor;
  final Color accentColor;

  const richTextTitle({
    super.key,
    required this.mainTitle,
    required this.accentTitle,
    this.fontSize = Appsized.fontxxl,
    this.mainColor = Colors.black,
    this.accentColor = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: mainColor,
        ),
        children: [
          TextSpan(text: mainTitle),
          TextSpan(
            text: accentTitle,
            style: TextStyle(color: accentColor),
          ),
        ],
      ),
    );
  }
}
