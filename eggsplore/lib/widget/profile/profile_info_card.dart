import 'package:flutter/material.dart';
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/pages/profile/detail_profile_page.dart';

class ProfileInfoCard extends StatelessWidget {
  final User user; // ✅ terima user dari parent

  const ProfileInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final displayName = user.name; // user pasti ada

    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProfileDetailPage(user: user),
            ),
          );
        },
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(12),
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
            children: [
              const CircleAvatar(
                radius: 26,
                backgroundImage: AssetImage("assets/images/default_pfp.png"),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  displayName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
