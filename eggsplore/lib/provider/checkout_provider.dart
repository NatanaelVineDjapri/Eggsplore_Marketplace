import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/order.dart';
import 'package:eggsplore/service/checkout_service.dart';
import 'package:eggsplore/service/user_service.dart'; 

final checkoutServiceProvider = Provider((ref) => CheckoutService());

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

class CheckoutNotifier extends AsyncNotifier<Order?> {
  
  @override
  Future<Order?> build() async {
    return null;
  }

  Future<void> checkout(CheckoutParams params) async {
    final checkoutService = ref.read(checkoutServiceProvider);
    final token = await UserService.getToken(); 
    if (token == null) {
      throw Exception("User tidak login.");
    }

    state = const AsyncLoading(); 

    try {
      final newOrder = await checkoutService.createOrder(
        token: token,
        shippingAddress: params.shippingAddress,
        receiverName: params.receiverName,
        receiverPhone: params.receiverPhone,
        items: params.items,
      );
      state = AsyncData(newOrder);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace); 
      rethrow; 
    }
  }
}

final checkoutProvider = AsyncNotifierProvider<CheckoutNotifier, Order?>(() {
  return CheckoutNotifier();
});