import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/text_style.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller buat ambil input user
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _minPurchaseController = TextEditingController();

  // Placeholder buat gambar
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

  // Simulasi kirim data ke backend
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
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black54), // label normal
      floatingLabelStyle: TextStyle(
        color: Colors.black87,
        backgroundColor: Colors.white.withOpacity(0.7), // bg label saat naik
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.7), // bg field semi transparan
      prefixText: prefix,
      prefixStyle: const TextStyle(color: Colors.black54), // prefix kalem
      hintStyle: const TextStyle(color: Colors.black54),  // hint kalem
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: const backBar(title: "Add Product"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upload Foto Produk
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      productImage = "assets/logo/placeholder.png";
                    });
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                        productImage != null ? AssetImage(productImage!) : null,
                    child: productImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Colors.black54)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Nama Produk
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Product Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter product name" : null,
              ),
              const SizedBox(height: 16),

              // Deskripsi Produk
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

              // Harga
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Price", prefix: "Rp "),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter price" : null,
              ),
              const SizedBox(height: 16),

              // Stock
              TextFormField(
                controller: _stockController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Stock"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter stock" : null,
              ),
              const SizedBox(height: 16),

              // Minimum pembelian
              TextFormField(
                controller: _minPurchaseController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black54),
                decoration: _inputDecoration("Minimum Purchase"),
                validator: (value) => value == null || value.isEmpty
                    ? "Enter minimum purchase"
                    : null,
              ),
              const SizedBox(height: 24),

              // Tombol Sell
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800], // abu tua
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
