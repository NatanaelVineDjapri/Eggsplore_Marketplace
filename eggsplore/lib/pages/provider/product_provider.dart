import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/model/review.dart';
import 'package:eggsplore/model/shop_products_args.dart';
import 'package:eggsplore/service/product_service.dart';

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

// --- BAGIAN YANG DIPERBAIKI ---

final allProductsProvider = FutureProvider<List<Product>>((ref) async {
  // Logika token dihapus dari sini
  return ProductService.fetchProducts(); // Panggil langsung tanpa argumen
});

final myProductsProvider = FutureProvider<List<Product>>((ref) async {
  // Logika token juga dihapus dari sini
  return ProductService.fetchMyProducts(); // Panggil langsung tanpa argumen
});

// --- AKHIR BAGIAN YANG DIPERBAIKI ---

final reviewsProvider = FutureProvider.autoDispose.family<List<Review>, int>((ref, productId) async {
  return ProductService.fetchReviews(productId);
});