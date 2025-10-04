import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/user.dart'; // Pastikan User Model diimpor
import 'package:eggsplore/service/user_service.dart'; // Pastikan UserService diimpor

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    final user = await UserService.login(email, password);
    state = user;
    _isLoading = false;
    return user != null;
  }

  Future<void> loadUser() async {
    _isLoading = true;
    final user = await UserService.getCurrentUser(); // ambil dari token kalau ada
    state = user;
    _isLoading = false;
  }

  Future<bool> register(
      String firstName, String lastName, String email, String password) async {
    _isLoading = true;
    final success =
        await UserService.register(firstName, lastName, email, password);
    _isLoading = false;
    return success;
  }

  Future<bool> verifyUser(
      String firstName, String lastName, String email) async {
    _isLoading = true;
    final success = await UserService.verifyUser(firstName, lastName, email);
    _isLoading = false;
    return success;
  }

  Future<bool> changePassword(
      String email, String newPassword, String confirmPassword) async {
    _isLoading = true;
    final success =
        await UserService.changePassword(email, newPassword, confirmPassword);
    _isLoading = false;
    return success;
  }

  Future<void> logout() async {
    await UserService.logout();
    state = null;
  }

  /// 🚨 FUNGSI INI DIGUNAKAN CHECKOUT UNTUK MEMPERBARUI SALDO TANPA PANGGIL API
  void updateBalance(double newBalance) {
    if (state != null) {
      // Menggunakan copyWith dari model User
      state = state!.copyWith(balance: newBalance); 
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});
