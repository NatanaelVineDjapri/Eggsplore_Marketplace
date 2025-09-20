import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/base/auth_base.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:eggsplore/widget/customForm.dart';
import 'package:eggsplore/widget/passwordForm.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                controller: firstNameController,
                label: AppStrings.firstName,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomForm(
                controller: lastNameController,
                label: AppStrings.lastName,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
          ],
        ),
        SizedBox(height: spacing.xl),
        CustomForm(
          controller: emailController,
          label: AppStrings.email,
          prefixIcon: const Icon(Icons.email),
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        SizedBox(height: spacing.xl),
        passwordForm(
          controller: passwordController,
          title: AppStrings.password,
        ),
      ],
      buttonText: "Register",
      onButtonPressed: () async {
        if (firstNameController.text.isEmpty ||
            lastNameController.text.isEmpty ||
            emailController.text.isEmpty ||
            passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form tidak boleh kosong')),
          );
          return;
        }

        final user = await UserService.register(
          firstNameController.text,
          lastNameController.text,
          emailController.text,
          passwordController.text,
        );

        Navigator.pushReplacementNamed(context, AppRoutes.login);
      },
    );
  }
}
