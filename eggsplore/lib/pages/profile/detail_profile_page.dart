import 'package:flutter/material.dart';
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/widget/profile/customize_profile.dart';

class ProfileDetailPage extends StatelessWidget {
  final User user;

  const ProfileDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage("assets/images/default_pfp.png"),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Nama: ${user.name}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text("Email: ${user.email}"),
            const SizedBox(height: 10),
            Text("Role: ${user.role}"),
            const SizedBox(height: 10),
            Text("Saldo: ${user.balance}"),
            const SizedBox(height: 20),

            // Tombol Edit Username
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CustomizeProfilePage(user: user),
                    ),
                  );
                },
                child: const Text("Edit Username"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
