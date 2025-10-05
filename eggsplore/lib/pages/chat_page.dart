import 'package:eggsplore/bar/backBar2.dart';
import 'package:eggsplore/constants/colors.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/model/user.dart'; 
import 'package:eggsplore/pages/provider/message_provider.dart';
import 'package:eggsplore/pages/provider/product_provider.dart';
import 'package:eggsplore/widget/chat/chat_item.dart';
import 'package:eggsplore/widget/random_product_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/pages/chat_account_page.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatAsync = ref.watch(chatProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: const backBar2(title: "Chat"), 

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chatAsync.when(
                data: (contacts) {
                  if (contacts.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          AppStrings.nochat,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final dynamic shop = contacts[index]; 
                      return ChatItem(
                        userId: shop.id as int,
                        name: shop.name as String,
                        username: shop.email as String, 
                        imagePath: shop.image as String?, 
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CircularProgressIndicator(color: Colors.orange),
                  ),
                ),
                error: (err, stack) => Center(
                  child: Text('${AppStrings.errchat} $err'),
                ),
              ),

              const SizedBox(height: 20), 
              RandomProductsGrid()
            ],
          ),
        ),
      ),
    );
  }
}
