import 'package:flutter/material.dart';

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
        children: const [
          Expanded(
            child: _ActionItem(icon: Icons.receipt_long, label: "Transaction"),
          ),
          Expanded(
            child: _ActionItem(icon: Icons.timelapse, label: "On Process"),
          ),
          Expanded(
            child: _ActionItem(icon: Icons.send, label: "Sent"),
          ),
          Expanded(
            child: _ActionItem(icon: Icons.reviews, label: "Reviews"),
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    void navigate() {
      switch (label) {
        case "Transaction":
          Navigator.pushNamed(context, '/transaction');
          break;
        case "On Process":
          Navigator.pushNamed(context, '/on-process');
          break;
        case "Sent":
          Navigator.pushNamed(context, '/sent');
          break;
        case "Reviews":
          Navigator.pushNamed(context, '/reviews');
          break;
      }
    }

    return InkWell(
      onTap: navigate,
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
