import 'package:flutter/material.dart';
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/pages/profile/detail_profile_page.dart';

class ProfileInfoCard extends StatelessWidget {
  final User? user;

  const ProfileInfoCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = user?.name ?? 'Guest';
    final imagePath = user?.image ?? '';
    const androidEmulatorServer = "http://10.0.2.2:8000";

    final imageUrl = imagePath.isNotEmpty
        ? NetworkImage("$androidEmulatorServer$imagePath")
        : const AssetImage("assets/images/default_pfp.png") as ImageProvider;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Arahkan ke halaman detail jika user tidak null
          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                // Mengarah ke ProfileDetailPage yang sudah Anda buat
                builder: (context) => ProfileDetailPage(user: user!),
              ),
            );
          }
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
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: imageUrl,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

