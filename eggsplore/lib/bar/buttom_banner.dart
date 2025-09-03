import 'package:flutter/material.dart';
import '../../constants/text_string.dart';
import '../../constants/text_style.dart';

class BottomBanner extends StatelessWidget {
  const BottomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var text in AppStrings.bottomBannerText)
            Text(text, style: bottomBannerTextStyle),
        ],
      ),
    );
  }
}
