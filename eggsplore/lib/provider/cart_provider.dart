import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/cart_item.dart';
import '../service/cart_service.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  // Load cart dari API
  Future<void> loadCart() async {
    try {
      final items = await CartService.fetchCart();
      state = items;
    } catch (e) {
      print("Failed to load cart: $e");
    }
  }

  // Tambah item ke cart
  Future<void> addItem(int productId, int quantity) async {
    try {
      final newItem = await CartService.addCartItem(productId, quantity);
      final index = state.indexWhere((item) => item.id == newItem.id);
      if (index >= 0) {
        state = [
          ...state.sublist(0, index),
          newItem,
          ...state.sublist(index + 1),
        ];
      } else {
        state = [...state, newItem];
      }
    } catch (e) {
      print("Failed to add item: $e");
    }
  }

  // Update quantity
  Future<void> updateItem(int itemId, int quantity) async {
    try {
      await CartService.updateCartItem(itemId, quantity);
      final index = state.indexWhere((item) => item.id == itemId);
      if (index >= 0) {
        final updatedItem = state[index].copyWith(quantity: quantity);
        state = [
          ...state.sublist(0, index),
          updatedItem,
          ...state.sublist(index + 1),
        ];
      }
    } catch (e) {
      print("Failed to update item: $e");
    }
  }

  // Remove item
  Future<void> removeItem(int itemId) async {
    try {
      await CartService.removeCartItem(itemId);
      state = state.where((item) => item.id != itemId).toList();
    } catch (e) {
      print("Failed to remove item: $e");
    }
  }

  // Hitung total harga
  double get totalPrice =>
      state.fold(0, (sum, item) => sum + item.price * item.quantity);
}

// Provider global
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
