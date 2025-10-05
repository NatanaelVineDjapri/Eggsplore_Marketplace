import 'package:eggsplore/model/user.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/pages/modify_profile_info_page.dart'; 

class ProfileInfoCard extends StatelessWidget {
  final User? user;

  const ProfileInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final displayName = user?.name ?? 'Guest';
    final imagePath = user?.image ?? '';
    const androidEmulatorServer = "http://10.0.2.2:8000";
    const iosEmulatorServer = "http://localhost:8000";

    final baseServerUrl = Theme.of(context).platform == TargetPlatform.iOS
        ? iosEmulatorServer
        : androidEmulatorServer;

    final imageUrl = imagePath.isNotEmpty
        ? NetworkImage("$baseServerUrl$imagePath")
        : const AssetImage("assets/images/default_pfp.png") as ImageProvider;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ModifyProfileInfoPage(currentUser: user!),
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
              CircleAvatar(radius: 26, backgroundImage: imageUrl),
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
              const Spacer(),
              const Icon(Icons.edit_rounded, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
