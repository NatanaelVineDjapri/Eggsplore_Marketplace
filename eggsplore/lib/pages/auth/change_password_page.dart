import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/base/auth_base.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:eggsplore/widget/customForm.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _handleContinue() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field wajib diisi")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final success = await UserService.verifyUser(
      firstNameController.text.trim(),
      lastNameController.text.trim(),
      emailController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      Navigator.pushNamed(
        context,
        AppRoutes.newpassword,
        arguments: emailController.text.trim(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User tidak ditemukan")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Appsized(context);
    return AuthPage(
      title: "Forgot Your ",
      accentTitle: AppStrings.password,
      subtitle: "Time to update your password!",
      imagePaths: AppImages.fourthLogo,
      fields: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomForm(
                controller: firstNameController,
                label: AppStrings.firstName,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
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
        const SizedBox(height: 65),
      ],
      buttonText: _isLoading ? "Loading..." : "Continue",
      onButtonPressed: _isLoading ? null : _handleContinue,
    );
  }
}
