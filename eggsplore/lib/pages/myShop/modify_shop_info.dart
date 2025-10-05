import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart'; // Pastikan path import ini benar
import 'package:eggsplore/constants/text_style.dart'; // Pastikan path import ini benar
import 'package:eggsplore/model/shop.dart'; // Pastikan path import ini benar
import 'package:eggsplore/service/shop_service.dart';// Pastikan path ini benar (services vs service)
import 'package:intl/intl.dart';

class ModifyShopInfoPage extends StatefulWidget {
  // Constructor tidak lagi memerlukan shopId
  const ModifyShopInfoPage({super.key});

  @override
  State<ModifyShopInfoPage> createState() => _ModifyShopInfoPageState();
}

class _ModifyShopInfoPageState extends State<ModifyShopInfoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  bool _isLoading = true;
  bool _isSaving = false;
  
  Shop? _currentShop; 

  @override
  void initState() {
    super.initState();
    _fetchShopData();
  }

  Future<void> _fetchShopData() async {
    Shop? shop = await ShopService.getMyShop(); 
    
    if (shop != null && mounted) {
      setState(() {
        _currentShop = shop; 
        _nameController.text = shop.name;
        _descriptionController.text = shop.description;
        _dateController.text = DateFormat('d MMMM yyyy').format(shop.createdAt);
        _isLoading = false;
      });
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not find your shop data.")),
        );
        Navigator.of(context).pop(); 
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && !_isSaving && _currentShop != null) {
      setState(() {
        _isSaving = true;
      });

      final Map<String, dynamic> shopData = {
        "name": _nameController.text.trim(),
        "description": _descriptionController.text.trim(),
      };

      bool success = await ShopService.updateShop(_currentShop!.id, shopData);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Shop info updated successfully!")),
          );
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to update shop info.")),
          );
        }

        setState(() {
          _isSaving = false;
        });
      }
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.black87),
                      decoration: _inputDecoration("Shop Name"),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Enter shop name" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      style: const TextStyle(color: Colors.black87),
                      decoration: _inputDecoration("Description"),
                      maxLines: 3,
                      validator: (value) =>
                          value == null || value.isEmpty ? "Enter description" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _dateController,
                      style: const TextStyle(color: Colors.black54),
                      decoration: _inputDecoration("Created Date"),
                      readOnly: true,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          textStyle: AppTextStyle.mainTitle2,
                        ),
                        onPressed: _isSaving ? null : _submitForm,
                        child: _isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
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