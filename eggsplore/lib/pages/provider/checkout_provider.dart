import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/order.dart';
import 'package:eggsplore/service/checkout_service.dart';
import 'package:eggsplore/service/user_service.dart';

// Provider sederhana untuk menyediakan instance CheckoutService
final checkoutServiceProvider = Provider((ref) => CheckoutService());

// Tipe data untuk parameter yang akan diterima oleh Notifier
class CheckoutParams {
  final String shippingAddress;
  final String receiverName;
  final String receiverPhone;
  final List<CartItemToSend> items;
  
  CheckoutParams({
    required this.shippingAddress,
    required this.receiverName,
    required this.receiverPhone,
    required this.items,
  });
}

// Notifier yang menjadi "otak" proses
class CheckoutNotifier extends AsyncNotifier<Order?> {
  
  @override
  Future<Order?> build() async {
    // State awal adalah null, karena belum ada order yang dibuat
    return null;
  }

  Future<void> checkout(CheckoutParams params) async {
    // Ambil service dan token
    final checkoutService = ref.read(checkoutServiceProvider);
    // Asumsi Anda punya cara untuk mengambil token, misal dari UserService
    final token = await UserService.getToken(); 
    if (token == null) {
      throw Exception("User tidak login.");
    }

    state = const AsyncLoading(); // Set state ke loading

    try {
      final newOrder = await checkoutService.createOrder(
        token: token,
        shippingAddress: params.shippingAddress,
        receiverName: params.receiverName,
        receiverPhone: params.receiverPhone,
        items: params.items,
      );
      state = AsyncData(newOrder); // Jika berhasil, simpan order baru di state
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace); // Jika gagal, simpan error di state
      rethrow; // Lempar lagi errornya agar UI bisa menangkapnya
    }
  }
}

// Provider global yang akan diakses oleh UI
final checkoutProvider = AsyncNotifierProvider<CheckoutNotifier, Order?>(() {
  return CheckoutNotifier();
});