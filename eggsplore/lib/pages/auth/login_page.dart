import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/base/auth_base.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/pages/auth/change_password_page.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:eggsplore/widget/customForm.dart';
import 'package:eggsplore/widget/passwordForm.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final spacing = Appsized(context);

    return AuthPage(
      title: "Login",
      accentTitle: "Account",
      subtitle: "Welcome back to the app",
      imagePaths: AppImages.thirdLogo,
      fields: [
        // Email field
        CustomForm(
          controller: emailController,
          label: AppStrings.email,
          prefixIcon: Icon(Icons.email),
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        SizedBox(height: spacing.xl),
        passwordForm(
          controller: passwordController,
          title: AppStrings.password,
        ),
        SizedBox(height: spacing.xs),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.changepassword);
            },
            child: Text(
              AppStrings.forgetPassword,
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 90),
      ],
      buttonText: "Login",
      onButtonPressed: () async {
        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email & Password tidak boleh kosong'),
            ),
          );
          return;
        }

        final user = await UserService.login(
          emailController.text,
          passwordController.text,
        );

        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login gagal, cek email/password')),
          );
        } else {
          Navigator.pushNamed(context, AppRoutes.homepage);
        }
      },
      footerText: 'test',
    );
  }
}
