// lib/widgets/cart_item_widget.dart
import 'package:flutter/material.dart';
import '../model/product.dart';

class CartItemWidget extends StatefulWidget {
  final Product product;
  final int initialQuantity;
  final bool initiallySelected;
  final ValueChanged<int>? onQuantityChanged;
  final ValueChanged<bool>? onSelectedChanged;

  const CartItemWidget({
    super.key,
    required this.product,
    this.initialQuantity = 1,
    this.initiallySelected = true,
    this.onQuantityChanged,
    this.onSelectedChanged,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late int _quantity;
  late bool _selected;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
    _selected = widget.initiallySelected;
  }

  void _inc() {
    setState(() {
      _quantity++;
    });
    widget.onQuantityChanged?.call(_quantity);
  }

  void _dec() {
    if (_quantity <= 1) return;
    setState(() {
      _quantity--;
    });
    widget.onQuantityChanged?.call(_quantity);
  }

  void _toggleSelected(bool? v) {
    setState(() {
      _selected = v ?? false;
    });
    widget.onSelectedChanged?.call(_selected);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Checkbox(
              value: _selected,
              onChanged: _toggleSelected,
            ),
            // gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                p.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(width: 80, height: 80, color: Colors.grey[300]),
              ),
            ),
            const SizedBox(width: 12),
            // detail
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 6),
                  Text(p.shopName, style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // qty control
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.remove),
                              onPressed: _dec,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              child: Text('$_quantity'),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.add),
                              onPressed: _inc,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Rp ${ (p.price * _quantity).toString()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // optional remove icon (just visual)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                // jika mau support remove dari parent, bisa panggil callback lewat onQuantityChanged = 0
                // untuk sementara kita hanya show snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${p.name} dihapus (demo)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}