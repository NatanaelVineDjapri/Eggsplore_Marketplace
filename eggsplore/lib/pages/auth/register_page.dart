import 'package:eggsplore/base/auth_base.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/widget/customForm.dart';
import 'package:eggsplore/widget/passwordForm.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = Appsized(context);

    return AuthPage(
      title: "Register",
      accentTitle: "Account",
      subtitle: "Set your account",
      imagePaths: AppImages.fourthLogo,
      fields: [
        Row(
          children: [
            Expanded(
              child: CustomForm(
                label: AppStrings.firstName,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomForm(
                label: AppStrings.lastName,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
          ],
        ),
        SizedBox(height: spacing.xl),
        CustomForm(
          label: AppStrings.email,
          prefixIcon: const Icon(Icons.email),
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        SizedBox(height: spacing.xl),
        const passwordForm(title: AppStrings.password),
      ],
      buttonText: "Register",
      onButtonPressed: () {
        // TODO: action register
      },
    );
  }
}
