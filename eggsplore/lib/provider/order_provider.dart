// lib/provider/order_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/order.dart';
import '../service/order_service.dart';

final orderHistoryProvider = FutureProvider<List<Order>>((ref) async {
  return OrderService.getOrderHistory();
});

final orderDetailProvider = FutureProvider.family<Order, int>((ref, orderId) async {
  return OrderService.getOrderDetail(orderId);
});