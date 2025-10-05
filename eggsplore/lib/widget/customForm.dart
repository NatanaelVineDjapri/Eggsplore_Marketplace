import 'package:eggsplore/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final String label;
  final bool obscureText;
  final double? width;
  final double height;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const CustomForm({
    super.key,
    required this.label,
    this.obscureText = false,
    this.width,
    this.height = 55,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    double finalWidth = width ?? MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: Appsized.fontLg,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: finalWidth,
          height: height,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
