import 'package:flutter/foundation.dart'; 

@immutable 
class ShopProductsArgs {
  final int shopId;
  final int excludeProductId;

  const ShopProductsArgs({
    required this.shopId,
    required this.excludeProductId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ShopProductsArgs &&
        other.shopId == shopId &&
        other.excludeProductId == excludeProductId;
  }

  @override
  int get hashCode => shopId.hashCode ^ excludeProductId.hashCode;
}