import 'package:eggsplore/base/auth_base.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/widget/customForm.dart';
import 'package:eggsplore/widget/passwordForm.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      title: "Register",
      subtitle: "Set your account",
      fields:  [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomForm(
                label: AppStrings.firstName,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: CustomForm(
                label: AppStrings.lastName,
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ],
        ),
        const SizedBox(height: Appsized.xl),
        CustomForm(
          label: AppStrings.email,
          prefixIcon: Icon(Icons.email),
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        const SizedBox(height: Appsized.xl),
        const passwordForm()
        
      ],
      buttonText: "Register",
      onButtonPressed: () {
        // TODO: action register
      },
    );
  }
}
