import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/message.dart';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/service/message_service.dart';
import 'package:eggsplore/service/product_service.dart';
import 'package:eggsplore/widget/product.dart';
import 'package:eggsplore/pages/chat_account_page.dart';

// Provider untuk chat
final chatProvider = FutureProvider<List<UserChat>>((ref) async {
  return await MessageService.getInbox();
});

// Provider untuk produk rekomendasi
final productProvider = FutureProvider<List<Product>>((ref) async {
  return await ProductService.fetchRandomProductsForCurrentUser();
});

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final chatAsync = ref.watch(chatProvider);
    final productAsync = ref.watch(productProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: Colors.orange,
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
                                style: const TextStyle(color: Colors.white),
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

              // PRODUCT RECOMMENDATION
              Text(
                "Produk Rekomendasi",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              productAsync.when(
                data: (products) {
                  if (products.isEmpty) {
                    return const Center(
                      child: Text(
                        "Tidak ada produk rekomendasi.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 12),
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        name: product.name,
                        price: product.price,
                        image: product.image,
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
                  child: Text("Error produk: $err"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
