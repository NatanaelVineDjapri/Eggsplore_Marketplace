import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/model/shop.dart';
import 'package:eggsplore/service/shop_service.dart';

class ModifyShopInfoPage extends StatefulWidget {
  // 1. Menerima shopId dari halaman sebelumnya
  final int shopId;

  const ModifyShopInfoPage({super.key, required this.shopId});

  @override
  State<ModifyShopInfoPage> createState() => _ModifyShopInfoPageState();
}

class _ModifyShopInfoPageState extends State<ModifyShopInfoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    // 2. Panggil fungsi untuk mengambil data saat halaman dimuat
    _fetchShopDetails();
  }

  Future<void> _fetchShopDetails() async {
    Shop? shop = await ShopService.getShopDetails(widget.shopId);
    if (mounted) {
      if (shop != null) {
        setState(() {
          _nameController.text = shop.name;
          _descriptionController.text = shop.description;
          _dateController.text = DateFormat('dd MMMM yyyy').format(shop.createdAt);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Gagal memuat data toko.";
          _isLoading = false;
        });
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

  // 3. Perbarui fungsi submit untuk mengirim data ke API
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Tampilkan dialog loading saat proses update
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final Map<String, dynamic> shopData = {
        "name": _nameController.text.trim(), // Gunakan key "name" sesuai backend
        "description": _descriptionController.text.trim(),
      };

      bool success = await ShopService.updateShop(widget.shopId, shopData);

      if (mounted) {
        Navigator.of(context).pop(); // Tutup dialog loading

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Info toko berhasil diperbarui!"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Gagal memperbarui info toko."),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  InputDecoration _inputDecoration(String label) {
    // Fungsi ini tidak perlu diubah
    return InputDecoration(
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.black87, fontSize: 14),
        ),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffae11),
      appBar: const backBar(title: "Modify Shop Info"),
      // 4. Tampilkan loading atau error jika ada
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage, style: const TextStyle(color: Colors.white, fontSize: 16)))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.black54),
                          decoration: _inputDecoration("Shop Name"),
                          validator: (value) => value == null || value.isEmpty ? "Masukkan nama toko" : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          style: const TextStyle(color: Colors.black54),
                          decoration: _inputDecoration("Description"),
                          maxLines: 3,
                          validator: (value) => value == null || value.isEmpty ? "Masukkan deskripsi" : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _dateController,
                          style: const TextStyle(color: Colors.black54),
                          decoration: _inputDecoration("Created Date"),
                          // 5. Jadikan field ini tidak bisa diedit
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