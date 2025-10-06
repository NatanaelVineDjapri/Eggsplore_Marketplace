// lib/models/shop_with_products.dart

import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/model/shop.dart';


class ShopWithProducts {
  final Shop shop;
  final List<Product> products;

  ShopWithProducts({
    required this.shop,
    required this.products,
  });

  factory ShopWithProducts.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<Product> products = productList.map((p) => Product.fromJson(p)).toList();

    return ShopWithProducts(
      shop: Shop.fromJson(json),
      products: products,
    );
  }
}