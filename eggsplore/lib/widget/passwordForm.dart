import 'package:eggsplore/widget/customForm.dart';
import 'package:flutter/material.dart';

class passwordForm extends StatefulWidget {
  final String title;
  final TextEditingController? controller;

  const passwordForm({super.key, required this.title, this.controller});

  @override
  State<passwordForm> createState() => passwordFormState();
}

class passwordFormState extends State<passwordForm> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      label: widget.title,
      controller: widget.controller,
      obscureText: obscureText,
      prefixIcon: const Icon(Icons.lock),
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
    );
  }
}
