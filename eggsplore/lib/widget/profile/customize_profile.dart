import 'package:flutter/material.dart';
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/service/user_service.dart';

class CustomizeProfilePage extends StatefulWidget {
  final User user;

  const CustomizeProfilePage({super.key, required this.user});

  @override
  State<CustomizeProfilePage> createState() => _CustomizeProfilePageState();
}

class _CustomizeProfilePageState extends State<CustomizeProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.name);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _saveUsername() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Panggil UserService untuk update username
    final success = await UserService.updateProfile({'name': _usernameController.text});

    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username berhasil diperbarui")),
      );
      Navigator.pop(context); // kembali ke detail profile
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal memperbarui username")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customize Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Username tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveUsername,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}