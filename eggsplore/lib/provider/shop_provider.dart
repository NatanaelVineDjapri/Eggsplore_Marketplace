import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/shop.dart';
import 'package:eggsplore/service/shop_service.dart';

final shopsProvider = FutureProvider<List<Shop>>((ref) async {
  return ShopService.fetchShops();
});

final shopDetailProvider = FutureProvider.family<Shop, int>((ref, id) async {
  final shop = await ShopService.fetchShopDetail(id);
  if (shop == null) throw Exception("Shop not found");
  return shop;
});