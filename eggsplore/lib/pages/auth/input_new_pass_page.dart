import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/base/auth_base.dart';
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
    return AuthPage(
      title: "Input a new",
      accentTitle: "Password",
      subtitle: "Let's set a new password for you!",
      fields: [
        // Email field
        const passwordForm(title: AppStrings.newPassword),
        const SizedBox(height: Appsized.xl),
        const passwordForm(title: AppStrings.confirmPassword,),
        const SizedBox(height: Appsized.xs),
        const SizedBox(height:62)
      ],
      buttonText: "Update",
      onButtonPressed: () {
        Navigator.pushNamed(context, AppRoutes.register);
      },
    );
  }
}
