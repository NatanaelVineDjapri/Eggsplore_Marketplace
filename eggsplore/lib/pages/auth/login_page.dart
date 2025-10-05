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

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Appsized(context);

    return AuthPage(
      title: AppStrings.login,
      accentTitle: AppStrings.account,
      subtitle: AppStrings.loginSub,
      imagePaths: AppImages.thirdLogo,
      fields: [
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
        SizedBox(height: spacing.xs),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.changepassword);
            },
            child: const Text(
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
      buttonText: _isLoading ? AppStrings.loading : AppStrings.login,
      onButtonPressed: _isLoading
          ? null
          : () async {
              if (emailController.text.isEmpty ||
                  passwordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(AppStrings.formNull)),
                );
                return;
              }

              setState(() => _isLoading = true);
              final success = await ref
                  .read(authProvider.notifier)
                  .login(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
              setState(() => _isLoading = false);

              if (!success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(AppStrings.failLogin)),
                );
              } else {
                final user = ref.read(authProvider).value;

                // Lakukan pengecekan null sebelum menampilkan SnackBar
                if (user != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${AppStrings.welcomeBack}, ${user.name}",
                      ), // Sekarang aman, tidak perlu '?.' lagi
                    ),
                  );
                }
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.homepage,
                  (route) => false,
                );
              }
            },
      footerText: 'test',
    );
  }
}
