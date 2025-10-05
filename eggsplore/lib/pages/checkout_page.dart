import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:eggsplore/model/cart_item.dart';
import 'package:eggsplore/model/order.dart';
import 'package:eggsplore/provider/auth_provider.dart';
import 'package:eggsplore/provider/cart_provider.dart';
import 'package:eggsplore/provider/checkout_provider.dart';
import 'package:eggsplore/service/checkout_service.dart';
import 'package:eggsplore/constants/sizes.dart';

class CheckoutPage extends ConsumerWidget {
  final List<CartItem> itemsToCheckout;

  const CheckoutPage({super.key, required this.itemsToCheckout});

  Widget _buildProductRow(CartItem item, NumberFormat formatter, Appsized sizes) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizes.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: sizes.xxl,
            height: sizes.xxl,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(sizes.xs),
              color: Colors.grey[300],
            ),
            clipBehavior: Clip.hardEdge,
            child: item.image != null && item.image!.isNotEmpty
                ? Image.network(item.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image))
                : const Icon(Icons.image,
                    size: Appsized.iconLg, color: Colors.black45),
          ),
          SizedBox(width: Appsized.iconXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.shopName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Appsized.fontSm - 1)), 
                SizedBox(height: sizes.xss),
                Text(item.name, style: const TextStyle(color: Colors.black54)),
                SizedBox(height: sizes.xs),
                Text('${AppStrings.pricerp} ${formatter.format(item.price)}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Text("x${item.quantity}"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizes = Appsized(context);

    ref.listen<AsyncValue<Order?>>(checkoutProvider, (previous, current) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      if (current.isLoading) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text(AppStrings.orderproc)));
      }
      if (current.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppStrings.fail} ${current.error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      if (current.hasValue && current.value != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.successpay),
            backgroundColor: Colors.green,
          ),
        );
        ref.invalidate(authProvider);
        ref.invalidate(cartProvider);
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (context.mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.homepage,
              (Route<dynamic> route) => false,
            );
          }
        });
      }
    });

    final checkoutState = ref.watch(checkoutProvider);
    
    final user = ref.watch(authProvider).value;

    final formatter = NumberFormat('#,###', 'id_ID');
    final itemsSubtotal = itemsToCheckout.fold<double>(
        0, (sum, item) => sum + (item.price * item.quantity));
    final shippingFee = 10000;
    final serviceFee =
        (itemsSubtotal * 0.025).clamp(2000, double.infinity).toInt();
    final totalPayment = itemsSubtotal + shippingFee + serviceFee;
    final userBalance = user?.balance ?? 0;
    final bool saldoCukup = userBalance >= totalPayment;

    return Scaffold(
      backgroundColor: const Color(0xFFDADADA),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: sizes.xl,
                left: sizes.hmd,
                right: sizes.hmd,
                bottom: sizes.md),
            color: Colors.orange,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back,
                      color: Colors.black, size: Appsized.iconMd),
                ),
                SizedBox(width: Appsized.iconXs),
                const Text(AppStrings.co,
                    style: TextStyle(
                        fontSize: Appsized.fontLg + 2, // 20
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Appsized.iconXs),
              child: Column(
                children: [
                  _buildBox(
                    sizes: sizes,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user?.name ?? AppStrings.pleaselog,
                            style: const TextStyle(
                                fontSize: Appsized.fontMd,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: sizes.xs),
                        // DIUBAH: Menambahkan null-aware '?'
                        Text(user?.phoneNumber ?? AppStrings.minus),
                        SizedBox(height: sizes.xs),
                        Text(user?.address ?? AppStrings.logaddress,
                            style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                  SizedBox(height: Appsized.iconXs),
                  _buildBox(
                    sizes: sizes,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.prodordered,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: sizes.xs),
                        ...itemsToCheckout
                            .map((item) => _buildProductRow(item, formatter, sizes))
                            .toList(),
                      ],
                    ),
                  ),
                  SizedBox(height: Appsized.iconXs),
                  _buildBox(
                    sizes: sizes,
                    child: Column(
                      children: [
                        _buildRow(sizes, "Subtotal Pesanan", "Rp ${formatter.format(itemsSubtotal)}"),
                        _buildRow(sizes, "Subtotal Pengiriman", "Rp ${formatter.format(shippingFee)}"),
                        _buildRow(sizes, "Biaya Layanan", "Rp ${formatter.format(serviceFee)}"),
                        const Divider(color: Colors.orange, thickness: 1),
                        _buildRow(sizes, "Total Pembayaran", "Rp ${formatter.format(totalPayment)}", isBold: true),
                      ],
                    ),
                  ),
                  SizedBox(height: Appsized.iconXs),
                  _buildBox(
                    sizes: sizes,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.choosepaymethod, style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: Appsized.iconXs),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(Appsized.iconXs),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(sizes.xs),
                            border: Border.all(color: Colors.orange),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(AppStrings.paywith),
                              SizedBox(height: sizes.xs),
                              Row(
                                children: const [
                                  Icon(Icons.circle, size: Appsized.fontSm, color: Colors.orange),
                                  SizedBox(width: 6),
                                  Text(AppStrings.eggsplorepay),
                                ],
                              ),
                              SizedBox(height: sizes.xs),
                              Text('${AppStrings.acc} ${formatter.format(userBalance)}'),
                              if (user != null && !saldoCukup)
                                Padding(
                                  padding: EdgeInsets.only(top: sizes.xs),
                                  child: const Text(AppStrings.notenough, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                ),
                              if (user == null)
                                Padding(
                                  padding: EdgeInsets.only(top: sizes.xs),
                                  child: const Text(AppStrings.logintopay, style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: sizes.hmd, vertical: Appsized.iconXs),
            decoration: const BoxDecoration(
              color: Colors.orange,
              boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, -2), blurRadius: 4)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(AppStrings.sum, style: TextStyle(fontSize: Appsized.fontSm)),
                    SizedBox(height: sizes.xs),
                    Text('${AppStrings.pricerp} ${formatter.format(totalPayment)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: Appsized.fontMd)),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (saldoCukup && user != null) ? Colors.white : Colors.grey[400],
                    foregroundColor: (saldoCukup && user != null) ? Colors.black : Colors.black38,
                    padding: EdgeInsets.symmetric(horizontal: Appsized.iconMd, vertical: Appsized.iconXs),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizes.xs)),
                  ),
                  // DIUBAH: Mengisi kembali logika onPressed
                  onPressed: saldoCukup && user != null && !checkoutState.isLoading
                      ? () {
                          final params = CheckoutParams(
                            shippingAddress: user.address ?? 'Alamat belum diatur',
                            receiverName: user.name ?? 'Tanpa Nama',
                            receiverPhone: user.phoneNumber ?? '-',
                            items: itemsToCheckout
                                .map((item) => CartItemToSend(
                                      productId: item.productId,
                                      quantity: item.quantity,
                                    ))
                                .toList(),
                          );
                          ref.read(checkoutProvider.notifier).checkout(params);
                        }
                      : null,
                  child: checkoutState.isLoading
                      ? const SizedBox(
                          width: Appsized.iconMd,
                          height: Appsized.iconMd,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                        )
                      : const Text(AppStrings.co),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBox({required Widget child, required Appsized sizes}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Appsized.iconXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Appsized.iconXs),
      ),
      child: child,
    );
  }

  Widget _buildRow(Appsized sizes, String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizes.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: Appsized.fontSm, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: Appsized.fontSm, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}