import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/base/auth_base.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/widget/passwordForm.dart';
import 'package:eggsplore/provider/auth_provider.dart';

class NewPasswordPage extends ConsumerStatefulWidget {
  const NewPasswordPage({super.key});

  @override
  ConsumerState<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends ConsumerState<NewPasswordPage> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleUpdate() async {
    if (newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password tidak boleh kosong")),
      );
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password tidak sama")),
      );
      return;
    }

    final email = ModalRoute.of(context)!.settings.arguments as String;

    setState(() => _isLoading = true);
    final success = await ref.read(authProvider.notifier).changePassword(
          email,
          newPasswordController.text.trim(),
          confirmPasswordController.text.trim(),
        );
    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password berhasil diubah")),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal mengubah password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Appsized(context);
    return AuthPage(
      title: "Input a new",
      accentTitle: "Password",
      subtitle: "Let's set a new password for you!",
      imagePaths: AppImages.forgetPassLogo,
      fields: [
        passwordForm(
          controller: newPasswordController,
          title: AppStrings.newPassword,
        ),
        SizedBox(height: spacing.xl),
        passwordForm(
          controller: confirmPasswordController,
          title: AppStrings.confirmPassword,
        ),
        const SizedBox(height: 62),
      ],
      buttonText: _isLoading ? "Loading..." : "Update",
      onButtonPressed: _isLoading ? null : _handleUpdate,
    );
  }
}
