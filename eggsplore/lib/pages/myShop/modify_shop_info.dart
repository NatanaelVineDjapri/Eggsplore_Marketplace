import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/text_style.dart';

class ModifyShopInfoPage extends StatefulWidget {
  const ModifyShopInfoPage({super.key});

  @override
  State<ModifyShopInfoPage> createState() => _ModifyShopInfoPageState();
}

class _ModifyShopInfoPageState extends State<ModifyShopInfoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> shopData = {
        "shopName": _nameController.text.trim(),
        "description": _descriptionController.text.trim(),
        "createdDate": _dateController.text.trim(),
      };

      debugPrint("Shop Data: $shopData");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Shop info updated!")),
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
      appBar: const backBar(title: "Modify Shop Info"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shop Name
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Shop Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter shop name" : null,
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Description"),
                maxLines: 3,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter description" : null,
              ),
              const SizedBox(height: 16),

              // Created Date
              TextFormField(
                controller: _dateController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Created Date"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter created date" : null,
              ),
              const SizedBox(height: 24),

              // Save Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
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
