
// lib/model/cart_item.dart
class CartItem {
  final String shop;
  final String name;
  final int price;
  final String imageUrl;
  int qty;
  bool selected;

  CartItem({
    required this.shop,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.qty = 1,
    this.selected = false,
  });
}