import 'package:eggsplore/pages/chat_account_page.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/constants/colors.dart';
import '../../model/product.dart';

class ChatButtonProduct extends StatelessWidget {
  final Product product;
  final Color primaryColor;

  const ChatButtonProduct({
    super.key,
    required this.product,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: const Icon(Icons.message_outlined, color: AppColors.primary),
        iconSize: 24,
        padding: const EdgeInsets.all(8),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailPage(
                userId: product.shopId,
                username: product.userName,
              ),
            ),
          );
        },
      ),
    );
  }
}
