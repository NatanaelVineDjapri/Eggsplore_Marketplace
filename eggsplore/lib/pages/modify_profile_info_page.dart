import 'dart:io';
import 'package:eggsplore/constants/text_string.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentUser.name;
    _emailController.text = widget.currentUser.email;
    _phoneController.text = widget.currentUser.phoneNumber ?? '';
    _addressController.text = widget.currentUser.address ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
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
        "name": _nameController.text.trim(),
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
            const SnackBar(content: Text(AppStrings.modifysuccessprofile)),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.modifyfailprofile)),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppStrings.failedattempt} {$e}')),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : (widget.currentUser.image != null && widget.currentUser.image!.isNotEmpty
                            ? NetworkImage(widget.currentUser.image!) as ImageProvider
                            : null),
                    child: widget.currentUser.image == null && _selectedImage == null
                        ? const Icon(Icons.person, size: 60, color: Colors.grey)
                        : null,
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Nama Lengkap"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Masukkan nama lengkap" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Email"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Masukkan email" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Nomor Telepon"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Alamat"),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              
              // Save Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  textStyle: AppTextStyle.mainTitle2,
                ),
                onPressed: _submitForm,
                child: const Text(AppStrings.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}