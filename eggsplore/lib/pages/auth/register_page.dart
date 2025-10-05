import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/base/auth_base.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/widget/customForm.dart';
import 'package:eggsplore/widget/passwordForm.dart';
import 'package:eggsplore/pages/provider/auth_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form tidak boleh kosong')),
      );
      return;
    }

    setState(() => _isLoading = true);
    final success = await ref.read(authProvider.notifier).register(
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
        );
    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil, silakan login')),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi gagal, coba lagi')),
      );
    }
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
      buttonText: _isLoading ? "Loading..." : "Register",
      onButtonPressed: _isLoading ? null : _handleRegister,
    );
  }
}
