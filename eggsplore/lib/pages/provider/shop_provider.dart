// lib/providers/shop_provider.dart

import 'package:eggsplore/model/shop_with_products.dart';
import 'package:eggsplore/service/shop_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Provider ini langsung memanggil service dan me-return Future
final shopProvider = FutureProvider.family<ShopWithProducts, int>((ref, shopId) {
  // Logika memanggil service ada di sini
  return ShopService().getShopById(shopId);
});