import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/cart_item.dart';
import 'package:eggsplore/service/cart_service.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  double get totalPrice {
    return state.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  Future<void> loadCart() async {
    try {
      final items = await CartService.fetchCart();
      state = items;
    } catch (e) {
      print("❌ Failed to load cart: $e");
      state = [];
    }
  }

  Future<void> addItem(int productId, int quantity) async {
    try {
      final item = await CartService.addCartItem(productId, quantity);

      final existingIndex = state.indexWhere((i) => i.productId == productId);
      if (existingIndex != -1) {
        final updated = [...state];
        updated[existingIndex] = item;
        state = updated;
      } else {
        state = [...state, item];
      }
    } catch (e) {
      print("❌ Failed to add item: $e");
    }
  }

  Future<void> updateItem(int itemId, int newQty) async {
    try {
      await CartService.updateCartItem(itemId, newQty);
      state = [
        for (final i in state)
          if (i.id == itemId) i.copyWith(quantity: newQty) else i,
      ];
    } catch (e) {
      print("❌ Failed to update item: $e");
    }
  }

  Future<void> removeItem(int itemId) async {
    try {
      await CartService.removeCartItem(itemId);
      state = state.where((i) => i.id != itemId).toList();
    } catch (e) {
      print("❌ Failed to remove item: $e");
    }
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());
