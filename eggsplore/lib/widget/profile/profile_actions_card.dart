import 'package:flutter/material.dart';
import 'package:eggsplore/constants/colors.dart';

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
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.bleki.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: const [
          Expanded(child: _ActionItem(icon: Icons.receipt_long, label: "Transaction")),
          Expanded(child: _ActionItem(icon: Icons.timelapse, label: "On Process")),
          Expanded(child: _ActionItem(icon: Icons.send, label: "Sent")),
          Expanded(child: _ActionItem(icon: Icons.reviews, label: "Reviews")),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 28, color: AppColors.primary),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
