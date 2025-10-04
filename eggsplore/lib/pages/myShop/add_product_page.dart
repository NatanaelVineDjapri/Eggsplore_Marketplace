import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/service/product_service.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  File? _selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
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
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pilih gambar produk terlebih dahulu.")),
        );
        return;
      }

      final Map<String, dynamic> productData = {
        "name": _nameController.text.trim(),
        "description": _descriptionController.text.trim(),
        "price": double.tryParse(_priceController.text.trim()) ?? 0,
        "stock": int.tryParse(_stockController.text.trim()) ?? 0,
      };

      try {
        final success = await ProductService.addProduct(
          productData: productData,
          imagePath: _selectedImage!.path,
        );

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Produk berhasil ditambahkan!")),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Gagal menambahkan produk.")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Terjadi kesalahan: $e")),
        );
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
      appBar: const backBar(title: "Add Product"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!) as ImageProvider
                        : null,
                    child: _selectedImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Colors.black54)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Product Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter product name" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Product Description"),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? "Enter product description"
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Price", prefix: "Rp "),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter price" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stockController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Stock"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter stock" : null,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    textStyle: AppTextStyle.mainTitle2,
                  ),
                  onPressed: _submitForm,
                  child: const Text("SELL"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}