import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/order.dart';
import 'package:eggsplore/service/order_service.dart';

final orderProvider =
    StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  return OrderNotifier();
});

class OrderState {
  final bool isLoading;
  final String? error;
  final List<Order> orders;

  OrderState({
    this.isLoading = false,
    this.error,
    this.orders = const [],
  });

  OrderState copyWith({
    bool? isLoading,
    String? error,
    List<Order>? orders,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      orders: orders ?? this.orders,
    );
  }
}

class OrderNotifier extends StateNotifier<OrderState> {
  final _service = OrderService();

  OrderNotifier() : super(OrderState());

  Future<void> fetchOrders() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final fetchedOrders = await _service.getOrderHistory();
      state = state.copyWith(isLoading: false, orders: fetchedOrders);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
