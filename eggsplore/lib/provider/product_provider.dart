import 'package:eggsplore/model/review.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/service/product_service.dart';
import 'package:eggsplore/model/shop_products_args.dart';

final randomProductsProvider = FutureProvider<List<Product>>((ref) async {
  return ProductService.fetchRandomProductsForCurrentUser();
});

final productDetailProvider = FutureProvider.family<Product, int>((ref, productId) async {
  return ProductService.fetchProductDetail(productId);
});

// final productsFromShopProvider = FutureProvider.autoDispose.family<List<Product>, Map<String, int>>(
//   (ref, params) async {
//     final shopId = params['shopId'];
//     final excludeProductId = params['productId'];

//     if (shopId == null || excludeProductId == null) {
//       return [];
//     }

//     return ProductService.fetchProductsFromShop(
//       shopId: args.shopId, 
//       excludeProductId: args.excludeProductId, 
//     );
//   }
// );

final productsFromShopProvider = FutureProvider.autoDispose.family<List<Product>, ShopProductsArgs>(
  (ref, args) async {
    return ProductService.fetchProductsFromShop(
      shopId: args.shopId,
      excludeProductId: args.excludeProductId,
    );
  },
);

final allProductsProvider = FutureProvider<List<Product>>((ref) async {
  final token = await UserService.getToken();
  if (token == null || token.isEmpty) {
    throw Exception("Token tidak ditemukan");
  }
  return ProductService.fetchProducts(token);
});

final myProductsProvider = FutureProvider<List<Product>>((ref) async {
  final token = await UserService.getToken();
  if (token == null) {
    throw Exception("Pengguna tidak terautentikasi.");
  }
  return ProductService.fetchMyProducts(token);
});

final reviewsProvider = FutureProvider.autoDispose.family<List<Review>, int>((ref, productId) async {
  return ProductService.fetchReviews(productId);
});

