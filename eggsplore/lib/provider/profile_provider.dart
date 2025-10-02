import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/service/user_service.dart';

class ProfileNotifier extends StateNotifier<User?> {
  ProfileNotifier() : super(null);

  // Load current user dari backend
  Future<void> loadCurrentUser() async {
    final user = await UserService.getCurrentUser();
    state = user;
  }

  // Set user manual
  void setUser(User? user) {
    state = user;
  }

  // Update nama
  void updateName(String name) {
    if (state != null) {
      state = state!.copyWith(name: name);
    }
  }

  // Update email
  void updateEmail(String email) {
    if (state != null) {
      state = state!.copyWith(email: email);
    }
  }

  // Logout
  Future<void> logout() async {
    await UserService.logout();
    state = null;
  }
}

// Provider global
final profileProvider = StateNotifierProvider<ProfileNotifier, User?>(
  (ref) => ProfileNotifier(),
);
