import 'package:flutter/material.dart';
import 'package:eggsplore/pages/reviews.dart';
import 'package:eggsplore/pages/onprocess.dart';
import 'package:eggsplore/pages/sent_page.dart';
import 'package:eggsplore/pages/transaction_page.dart';

class ProfileActionsCard extends StatefulWidget {
  const ProfileActionsCard({super.key});

  @override
  State<ProfileActionsCard> createState() => _ProfileActionsCardState();
}

class _ProfileActionsCardState extends State<ProfileActionsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: _ActionItem(
              icon: Icons.receipt_long,
              label: "Transaction",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TransactionPage()), // tanpa const
                );
              },
            ),
          ),
          Expanded(
            child: _ActionItem(
              icon: Icons.timelapse,
              label: "On Process",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProcessedPage()),
                );
              },
            ),
          ),
          Expanded(
            child: _ActionItem(
              icon: Icons.send,
              label: "Sent",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SentPage()),
                );
              },
            ),
          ),
          Expanded(
            child: _ActionItem(
              icon: Icons.reviews,
              label: "Reviews",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReviewsPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionItem({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: Colors.orange),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
