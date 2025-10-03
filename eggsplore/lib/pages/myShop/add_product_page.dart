import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/constants/colors.dart';

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
  final TextEditingController _minPurchaseController = TextEditingController();

  String? productImage;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _minPurchaseController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> productData = {
        "name": _nameController.text.trim(),
        "description": _descriptionController.text.trim(),
        "price": double.tryParse(_priceController.text.trim()) ?? 0,
        "stock": int.tryParse(_stockController.text.trim()) ?? 0,
        "minPurchase": int.tryParse(_minPurchaseController.text.trim()) ?? 1,
        "image": productImage ?? "no_image.png",
      };

      debugPrint("Product Data: $productData");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product submitted!")),
      );
    }
  }

  InputDecoration _inputDecoration(String label, {String? prefix}) {
    return InputDecoration(
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.white, 
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.bleki,
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
      prefixStyle: const TextStyle(color: AppColors.bleki),
      hintStyle: const TextStyle(color: AppColors.bleki),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
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
                  onTap: () {
                    setState(() {
                      productImage = "assets/logo/placeholder.png";
                    });
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.grey[300],
                    backgroundImage:
                        productImage != null ? AssetImage(productImage!) : null,
                    child: productImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: AppColors.bleki)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: AppColors.bleki),
                decoration: _inputDecoration("Product Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter product name" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: AppColors.bleki),
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
                style: const TextStyle(color: AppColors.bleki),
                decoration: _inputDecoration("Stock"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter stock" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _minPurchaseController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.bleki),
                decoration: _inputDecoration("Minimum Purchase"),
                validator: (value) => value == null || value.isEmpty
                    ? "Enter minimum purchase"
                    : null,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.grey[800],
                    foregroundColor: AppColors.white,
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
