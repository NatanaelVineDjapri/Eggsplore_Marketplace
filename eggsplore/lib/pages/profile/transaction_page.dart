import 'package:eggsplore/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/pages/provider/transaction_prodiver.dart';
import 'package:eggsplore/widget/transaction_card.dart';

class TransactionPage extends ConsumerWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Transaction> transactions = ref.watch(transactionProvider);

    const String userProfileImagePath = 'assets/images/capy.png';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Daftar Transaksi"),
        backgroundColor: const Color(0xFFFFAE11),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: userProfileImagePath.isNotEmpty
                  ? AssetImage(userProfileImagePath) as ImageProvider
                  : null,
              child: userProfileImagePath.isEmpty
                  ? const Icon(Icons.person, color: Colors.white, size: 24)
                  : null,
              backgroundColor: Colors.white.withOpacity(0.3),
            ),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (transactions.isEmpty) {
            return const Center(child: Text("Belum ada transaksi."));
          }
          // Urutkan transaksi dari yang paling baru
          transactions.sort((a, b) => b.date.compareTo(a.date));

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return TransactionCard(transaction: transactions[index]);
            },
          );
        },
      ),
    );
  }
}