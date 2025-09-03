import 'package:eggsplore/base/auth_base.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/widget/customForm.dart';
import 'package:eggsplore/widget/passwordForm.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      title: "Login",
      subtitle: "Welcome back to the app",
      fields: [
        // Email field
        CustomForm(
          label: AppStrings.email,
          prefixIcon: Icon(Icons.email),
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        const SizedBox(height: Appsized.xl),
        const passwordForm(),
        const SizedBox(height: Appsized.xs),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            AppStrings.forgetPassword,
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold
              ),
          ),
        ),
        const SizedBox(height:90)
      ],
      buttonText: "Login",
      onButtonPressed: () {
        // TODO: action login
      },
      footerText: 'test',
    );
  }
}
