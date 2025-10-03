import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/provider/profile_provider.dart';
import 'package:eggsplore/service/user_service.dart';

class ModifyProfilePage extends ConsumerStatefulWidget {
  final User user;

  const ModifyProfilePage({super.key, required this.user});

  @override
  ConsumerState<ModifyProfilePage> createState() => _ModifyProfilePageState();
}

class _ModifyProfilePageState extends ConsumerState<ModifyProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  late TextEditingController _passwordController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final profileData = {
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "bio": _bioController.text.trim(),
      if (_passwordController.text.trim().isNotEmpty)
        "password": _passwordController.text.trim(),
    };

    final success = await UserService.updateProfile(profileData);

    setState(() => _isLoading = false);

    if (success) {
    ref.read(profileProvider.notifier).updateName(_nameController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile berhasil diperbarui")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal memperbarui profile")),
      );
    }
  }

  InputDecoration _inputDecoration(String label, {String? prefix}) {
    return InputDecoration(
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white,
      prefixText: prefix,
      prefixStyle: const TextStyle(color: Colors.black54),
      hintStyle: const TextStyle(color: Colors.black54),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffae11),
      appBar: const backBar(title: "Modify Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
 
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Full Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter your name" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your email";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Bio
              TextFormField(
                controller: _bioController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Bio"),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Password (optional)
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Password"),
              ),
              const SizedBox(height: 24),

              // Save Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    textStyle: AppTextStyle.mainTitle2,
                  ),
                  onPressed: _isLoading ? null : _submitForm,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("SAVE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}