import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/base/auth_base.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/widget/customForm.dart';
import 'package:eggsplore/widget/passwordForm.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = Appsized(context);
    return AuthPage(
      title: "Forgot Your ",
      accentTitle: AppStrings.password,
      subtitle: "Time to update your password!",
      imagePaths: AppImages.fourthLogo,
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
        SizedBox(height: spacing.xl),
        CustomForm(
          label: AppStrings.email,
          prefixIcon: Icon(Icons.email),
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        const SizedBox(height: 65),
        
      ],
      buttonText: "Continue",
      onButtonPressed: () {
        Navigator.pushNamed(context, AppRoutes.newpassword);

      },
    );
  }
}
