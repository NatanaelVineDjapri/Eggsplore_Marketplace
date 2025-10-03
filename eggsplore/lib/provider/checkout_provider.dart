// lib/provider/checkout_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/checkout_data.dart';
import '../service/checkout_service.dart';
// Pastikan path import ke AuthProvider Anda benar
import '../provider/auth_provider.dart'; 

final checkoutDataProvider = FutureProvider<CheckoutData>((ref) async {
  
  // 1. WATCH state dari authProvider. 
  // Jika User log out, provider ini akan otomatis di-invalidate.
  final user = ref.watch(authProvider); 

  // Penanganan: User harus login untuk melakukan checkout
  if (user == null) {
    // Kami melempar Exception karena data checkout tidak bisa diambil tanpa user ID.
    throw Exception("Akses ditolak. Pengguna belum terautentikasi.");
  }
  
  // 2. Gunakan ID dari user yang sedang login
  final userId = user.id; 
  
  // 3. Panggil service untuk mengambil data checkout
  return CheckoutService.getCheckoutData(userId);
});