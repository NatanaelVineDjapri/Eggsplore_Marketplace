import 'package:flutter/material.dart';
import 'package:eggsplore/constants/sizes.dart';

class BottomAuth extends StatelessWidget {
  final String text; 
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor ;

  const BottomAuth({
    super.key, 
    required this.text,
    this.onPressed,
    this.backgroundColor = Colors.orange,
    this.textColor = Colors.white,
    });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 50,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            side: const BorderSide(
              color: Colors.black,
              width: 1.2,
            ),
          ),
          child: Text( 
            text, 
            style: TextStyle(
              fontSize: Appsized.fontLg,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
