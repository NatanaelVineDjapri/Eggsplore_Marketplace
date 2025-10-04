import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/service/user_service.dart';

class ModifyProfileInfoPage extends StatefulWidget {
  final User currentUser;
  const ModifyProfileInfoPage({super.key, required this.currentUser});

  @override 
  State<ModifyProfileInfoPage> createState() => _ModifyProfileInfoPageState();
}

class _ModifyProfileInfoPageState extends State<ModifyProfileInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(); // Diubah menjadi _nameController
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentUser.name; // Menggunakan nama lengkap
    _emailController.text = widget.currentUser.email;
    _phoneController.text = widget.currentUser.phoneNumber ?? '';
    _addressController.text = widget.currentUser.address ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose(); // Diubah
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final updatedData = {
        "name": _nameController.text.trim(), // Mengirim 'name' saja
        "email": _emailController.text.trim(),
        "phone_number": _phoneController.text.trim(),
        "address": _addressController.text.trim(),
      };

      try {
        final success = await UserService.updateUserProfile(
          updatedData,
          imagePath: _selectedImage?.path,
        );

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profil berhasil diperbarui!")),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Gagal memperbarui profil.")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Terjadi kesalahan: $e")),
        );
      }
    }
  }

  InputDecoration _inputDecoration(String label) {
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
      hintStyle: const TextStyle(color: Colors.black54),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffae11),
      appBar: const backBar(title: "Modify Profile Info"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menggunakan satu field untuk nama lengkap
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Nama Lengkap"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Masukkan nama lengkap" : null,
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Email"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Masukkan email" : null,
              ),
              const SizedBox(height: 16),
              
              // Phone Number
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Nomor Telepon"),
              ),
              const SizedBox(height: 16),

              // Address
              TextFormField(
                controller: _addressController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Alamat"),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Profile Picture Picker
              Row(
                children: [
                  _selectedImage != null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage: FileImage(_selectedImage!),
                        )
                      : const CircleAvatar(
                          radius: 40,
                          child: Icon(Icons.person, size: 40),
                        ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text("Pilih Foto"),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Save Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    textStyle: AppTextStyle.mainTitle2,
                  ),
                  onPressed: _submitForm,
                  child: const Text("SAVE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}