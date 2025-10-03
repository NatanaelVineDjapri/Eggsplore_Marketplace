import 'package:eggsplore/constants/colors.dart';
import 'package:eggsplore/provider/message_provider.dart';
import 'package:eggsplore/provider/product_provider.dart';
import 'package:eggsplore/widget/random_product_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/pages/chat_account_page.dart';


class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final chatAsync = ref.watch(chatProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CHAT LIST
              chatAsync.when(
                data: (contacts) {
                  if (contacts.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          "💬 Belum ada chat.\nMulai percakapan dengan mencari user!",
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
                      final user = contacts[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Text(
                                user.name[0].toUpperCase(),
                                style: const TextStyle(color: AppColors.white),
                              ),
                            ),
                            title: Text(user.name),
                            subtitle: Text(user.email),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatDetailPage(
                                    userId: user.id,
                                    username: user.name,
                                  ),
                                ),
                              );
                            },
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                            height: 1,
                          ),
                        ],
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
                  child: Text("Error chat: $err"),
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
