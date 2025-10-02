import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/cart_item.dart';
import 'package:eggsplore/service/cart_service.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  // --- GETTERS ---
  double get totalPrice {
    return state.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get selectedTotalPrice {
    return state
        .where((item) => item.isSelected)
        .fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  List<CartItem> get selectedItems {
    return state.where((item) => item.isSelected).toList();
  }

  bool get allSelected {
    return state.isNotEmpty && state.every((item) => item.isSelected);
  }

  // --- ASYNC METHODS (API) ---
  
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
    final oldState = state;
    
    // Optimistic Update
    state = [
      for (final i in state)
        if (i.id == itemId)
          i.copyWith(quantity: newQty)
        else
          i,
    ];

    try {
      await CartService.updateCartItem(itemId, newQty);
    } catch (e) {
      print("❌ Failed to update item: $e");
      state = oldState; // Rollback
      // TODO: Tampilkan SnackBar error
    }
  }

  Future<void> removeItem(int itemId) async {
    final oldState = state;
    
    // Optimistic Update
    state = state.where((i) => i.id != itemId).toList();
    
    try {
      await CartService.removeCartItem(itemId);
    } catch (e) {
      print("❌ Failed to remove item: $e");
      state = oldState; // Rollback
      // TODO: Tampilkan SnackBar error
    }
  }

  /// Hapus semua item dari satu toko (Looped API Calls)
  Future<void> removeAllItemsByShop(String shopName) async {
    // Ambil item yang akan dihapus (kita butuh ID-nya)
    final itemsToRemove = state.where((i) => i.shopName == shopName).toList();
    
    if (itemsToRemove.isEmpty) return;

    final oldState = state;

    // 1. Optimistic Update: Hapus semua item toko tersebut dari UI
    state = state.where((i) => i.shopName != shopName).toList();
    
    // 2. Lakukan LOOP dan panggil API untuk setiap item secara paralel
    try {
      await Future.wait(
        itemsToRemove.map((item) => CartService.removeCartItem(item.id))
      );
      print("✅ Semua item dari toko '$shopName' berhasil dihapus via API calls.");
    } catch (e) {
      print("❌ Gagal hapus item toko '$shopName' (Error: $e). Melakukan Rollback.");
      state = oldState; // Rollback
      // TODO: Tampilkan SnackBar error
    }
  }

  // --- UI/TOGGLE LOGIC (STATE ONLY) ---

  void toggleSelect(int itemId) {
    state = [
      for (final item in state)
        if (item.id == itemId)
          item.copyWith(isSelected: !item.isSelected)
        else
          item,
    ];
  }

  void toggleSelectAll(bool selectAll) {
    state = [
      for (final item in state)
        item.copyWith(isSelected: selectAll),
    ];
  }

  void toggleShopSelect(String shopName, bool shouldSelect) {
    state = [
      for (final item in state)
        if (item.shopName == shopName)
          item.copyWith(isSelected: shouldSelect)
        else
          item,
    ];
  }

  // Di dalam class CartNotifier

/// Hapus semua item yang isSelected = true
Future<void> removeSelectedItems() async {
  final itemsToRemove = state.where((i) => i.isSelected).toList();
  
  if (itemsToRemove.isEmpty) return;

  final oldState = state;

  // 1. Optimistic Update: Hapus item yang dipilih dari UI
  state = state.where((i) => !i.isSelected).toList();
  
  // 2. Lakukan LOOP dan panggil API untuk setiap item
  try {
    await Future.wait(
      itemsToRemove.map((item) => CartService.removeCartItem(item.id))
    );
    print("✅ Semua item terpilih berhasil dihapus via API calls.");
  } catch (e) {
    print("❌ Gagal hapus item terpilih (Error: $e). Melakukan Rollback.");
    state = oldState; // Rollback
    // TODO: Tampilkan SnackBar error
  }
}
}

/// Provider utama
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);