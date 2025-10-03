import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/service/product_service.dart';


final randomProductsProvider = FutureProvider<List<Product>>((ref) async {
  return ProductService.fetchRandomProductsForCurrentUser();
});

final productDetailProvider = FutureProvider.family<Product, int>((ref, productId) async {
  return ProductService.fetchProductDetail(productId);

});

final productsFromShopProvider = FutureProvider.autoDispose.family<List<Product>, Map<String, int>>(
  (ref, params) async {
    final shopId = params['shopId'];
    final excludeProductId = params['productId'];

    if (shopId == null || excludeProductId == null) {
      return []; 
    }

    return ProductService.fetchProductsFromShop(
      shopId: shopId,
      excludeProductId: excludeProductId,
    );
  }
);