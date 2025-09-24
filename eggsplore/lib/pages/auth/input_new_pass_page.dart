import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/base/auth_base.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/pages/auth/change_password_page.dart';
import 'package:eggsplore/widget/customForm.dart';
import 'package:eggsplore/widget/passwordForm.dart';
import 'package:flutter/material.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage ({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = Appsized(context);
    return AuthPage(
      title: "Input a new",
      accentTitle: "Password",
      subtitle: "Let's set a new password for you!",
      imagePaths: AppImages.fourthLogo,
      fields: [
        // Email field
        const passwordForm(title: AppStrings.newPassword),
        SizedBox(height: spacing.xl),
        const passwordForm(title: AppStrings.confirmPassword,),
        SizedBox(height: spacing.xs),
        const SizedBox(height:62)
      ],
      buttonText: "Update",
      onButtonPressed: () {
        Navigator.pushNamed(context, AppRoutes.register);
      },
    );
  }
}
