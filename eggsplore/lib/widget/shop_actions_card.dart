import 'package:flutter/material.dart';
import 'package:eggsplore/app_routes.dart';

class ShopActionsCard extends StatelessWidget {
  const ShopActionsCard({super.key});

  Widget _buildAction(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[300],
            child: Icon(icon, size: 28, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAction(
            icon: Icons.shopping_bag,
            label: "Shop Orders",
            onTap: () => Navigator.pushNamed(context, AppRoutes.shopOrders),
          ),
          _buildAction(
            icon: Icons.check_circle,
            label: "Completed Orders",
            onTap: () => Navigator.pushNamed(context, AppRoutes.completedOrders),
          ),
          _buildAction(
            icon: Icons.add,
            label: "Add Product",
            onTap: () => Navigator.pushNamed(context, AppRoutes.addProduct),
          ),
        ],
      ),
    );
  }
}
