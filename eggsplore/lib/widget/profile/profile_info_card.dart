// DI FILE: lib/widget/profile/profile_info_card.dart

import 'package:flutter/material.dart';
// 🎯 Pastikan path import model User Anda benar
import 'package:eggsplore/model/user.dart'; 

class ProfileInfoCard extends StatelessWidget {
  // Menerima objek User lengkap (bisa null)
  final User? user;

  const ProfileInfoCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    
    // Fallback: Jika user null, tampilkan "Guest"
    // Pastikan model User Anda punya properti 'name'.
    final displayName = user?.name ?? 'Guest';

    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Logika navigasi ke edit user info
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
                  displayName, // Menampilkan data dinamis
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