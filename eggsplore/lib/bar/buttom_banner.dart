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
          Text(
            AppStrings.buttombanner1,
            style: bottomBannerTextStyle,
          ),
          Text(
            AppStrings.buttombanner2,
            style: bottomBannerTextStyle,
          ),
          Text(
            AppStrings.buttombanner3,
            style: bottomBannerTextStyle,
          ),
          Text(
            AppStrings.buttombanner4,
            style: bottomBannerTextStyle,
          ),
          Text(
            AppStrings.buttombanner5,
            style: bottomBannerTextStyle,
          )
        ],
      ),
    );
  }
}