import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/model/review.dart';
import 'package:eggsplore/model/shop_products_args.dart';
import 'package:eggsplore/service/product_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final trendingProductsProvider = FutureProvider<List<Product>>((ref) async {
  return ProductService.fetchTrendingProducts();
});


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
  },
);

final allProductsProvider = FutureProvider<List<Product>>((ref) async {
  return ProductService.fetchProducts(); 
});

final myProductsProvider = FutureProvider<List<Product>>((ref) async {

  return ProductService.fetchMyProducts(); 
});

final reviewsProvider = FutureProvider.autoDispose.family<List<Review>, int>((ref, productId) async {
  return ProductService.fetchReviews(productId);
});