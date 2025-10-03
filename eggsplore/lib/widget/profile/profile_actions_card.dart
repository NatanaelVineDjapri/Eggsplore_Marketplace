import 'package:eggsplore/pages/profilebar/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/pages/profilebar/transaction_detail_page.dart';
import 'package:eggsplore/pages/profilebar/onprocess.dart';
import 'package:eggsplore/pages/profilebar/sent_page.dart';
import 'package:eggsplore/pages/profilebar/reviews.dart';

class ProfileActionsCard extends StatelessWidget {
  const ProfileActionsCard({super.key});

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
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ActionItem(
            icon: Icons.receipt_long,
            label: "Transaction",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TransactionPage()),
              );
            },
          ),
          _ActionItem(
            icon: Icons.timelapse,
            label: "On Process",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProcessedPage()),
              );
            },
          ),
          _ActionItem(
            icon: Icons.send,
            label: "Sent",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SentPage()),
              );
            },
          ),
          _ActionItem(
            icon: Icons.reviews,
            label: "Reviews",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReviewsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8), // Agar efek ripple membulat
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: Colors.orange),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

