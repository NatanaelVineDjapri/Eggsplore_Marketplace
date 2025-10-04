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
final productsFromShopProvider = FutureProvider.autoDispose.family<List<Product>, ShopProductsArgs>(
  (ref, args) async {
  
    return ProductService.fetchProductsFromShop(
      shopId: args.shopId, 
      excludeProductId: args.excludeProductId, 
    );
  }
);

final allProductsProvider = FutureProvider<List<Product>>((ref) async {
  final token = await UserService.getToken();
  if (token == null || token.isEmpty) {
    throw Exception("Token tidak ditemukan");
  }
  return ProductService.fetchProducts(token);
});

final reviewsProvider = FutureProvider.autoDispose.family<List<Review>, int>((ref, productId) async {
  return ProductService.fetchReviews(productId);
});