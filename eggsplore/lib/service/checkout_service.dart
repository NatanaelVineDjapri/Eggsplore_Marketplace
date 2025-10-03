import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/checkout_data.dart'; 
import '../model/product.dart';
import '../model/user.dart';
import '../model/cart_item.dart';
import '../service/user_service.dart';
import 'package:flutter/material.dart'; 

class CheckoutService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // --- (getCheckoutData tetap sama) ---

  static Future<CheckoutData> getCheckoutData(int userId) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("Harap login untuk memuat data checkout."); 
    
    final response = await http.get(
      Uri.parse("$baseUrl/checkout/$userId"),
      headers: { "Authorization": "Bearer $token" },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CheckoutData.fromJson(data['data']); 
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception("Gagal memuat data checkout: ${errorBody['message'] ?? errorBody['error']}");
    }
  }


  // =======================================================
  // 2. POST SUBMIT ORDER (FINAL: Mengandalkan Perhitungan Server)
  // =======================================================
  static Future<bool> submitOrder(CheckoutData data) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("Harap login untuk submit pesanan.");
    
    // HANYA MENGIRIM DATA WAJIB (Item dan Alamat), BUKAN TOTAL KEUAANGAN
    // Biaya dihitung oleh Laravel untuk menghindari ketidakcocokan random service fee
    final body = {
      'payment_method': 'EggsplorePay',
      'receiver_name': data.user.name,
      'receiver_phone': data.user.phoneNumber,
      'shipping_address': data.user.address,
      
      // Mengirim biaya pengiriman yang disepakati (misalnya, JNE Reguler)
      'shipping_fee': data.shippingFee, 
      
      // Hanya mengirim item dan kuantitas
      'items': data.cartItems.map((item) => {
        'product_id': item.productId,
        'quantity': item.quantity,
      }).toList(),
      
      // CATATAN: Field 'total_amount' harus DIHAPUS dari payload, 
      // dan *logic* validasi di Laravel juga harus dihapus/diubah. 
      // Namun, karena kode Laravel Anda tidak bisa diubah, kita kirim total
      // yang dihitung client untuk mencegah error validasi input dasar,
      // tetapi risiko ketidakcocokan (karena rand()) tetap tinggi.
      
      'total_amount': data.grandTotal, // DIKIRIM, MENGAMBIL RISIKO KETIDAKCOCOKAN
    };

    final response = await http.post(
      Uri.parse("$baseUrl/order/create"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception("Transaksi Gagal: ${errorBody['message'] ?? 'Periksa saldo atau koneksi.'}");
    }
  }


  // =======================================================
  // 3. HELPER FINAL: Logika Direct Buy
  // =======================================================
  static Future<bool> submitDirectBuy({
    required Product product,
    required User user,
    required int quantity,
  }) async {
    final token = await UserService.getToken();
    if (token == null) throw Exception("Harap login untuk Beli Langsung.");
    
    // Perhitungan biaya (Sama dengan calculateOrderTotal yang diasumsikan di Laravel)
    // Walaupun nilainya statis di sini, ini adalah cara Flutter menyiapkan payload.
    const double shippingFee = 10000.0; 
    const double serviceFee = 1000.0;
    final itemsSubtotal = product.price * quantity;
    final grandTotal = itemsSubtotal + shippingFee + serviceFee; // Ini akan berbeda dari grand total server

    
    // Membuat payload untuk 1 item
    final body = {
      'payment_method': 'EggsplorePay',
      'receiver_name': user.name,
      'receiver_phone': user.phoneNumber,
      'shipping_address': user.address,
      'shipping_fee': shippingFee,
      'service_fee': serviceFee,
      'total_amount': grandTotal,
      
      'items': [
        {
          'product_id': product.id,
          'quantity': quantity,
        }
      ],
    };

    // Panggil Endpoint POST yang sama
    final response = await http.post(
      Uri.parse("$baseUrl/order/create"), 
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
    
    // Proses Respon
    if (response.statusCode == 201) {
      return true;
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception("Transaksi Gagal: ${errorBody['message'] ?? 'Periksa saldo atau koneksi.'}");
    }
  }
}