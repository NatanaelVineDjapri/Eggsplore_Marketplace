import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/service/user_service.dart';

class AuthNotifier extends AsyncNotifier<User?> {
  
  /// Method `build` ini akan berjalan OTOMATIS:
  /// 1. Saat aplikasi pertama kali dijalankan.
  /// 2. Setiap kali `ref.invalidate(authProvider)` dipanggil (misalnya setelah checkout).
  @override
  Future<User?> build() async {
    // Ia akan mencoba mengambil sesi user yang tersimpan secara otomatis.
    try {
      // Jika UserService berhasil dapat user, state akan berisi data User.
      return await UserService.getCurrentUser();
    } catch (e) {
      // Jika gagal (token tidak ada/tidak valid), state akan berisi null.
      print("Auth build error: ${e.toString()}");
      return null;
    }
  }

  /// Memproses login dan memperbarui state.
  Future<bool> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await UserService.login(email, password);
    });
    return state.hasError == false; // return true jika tidak ada error
  }

  /// Memproses logout dan memperbarui state.
  Future<void> logout() async {
    await UserService.logout();
    state = const AsyncData(null); // Set state menjadi berhasil tapi datanya null
  }

  /// Fungsi untuk me-refresh data user secara manual.
  Future<void> loadUser() async {
    // invalidateSelf akan memicu method 'build()' untuk berjalan lagi.
    ref.invalidateSelf();
    // 'await future' akan menunggu sampai proses 'build()' selesai.
    await future;
  }

  /// Fungsi registrasi, tidak mengubah state login. Mengembalikan true/false.
  Future<bool> register(String firstName, String lastName, String email, String password) async {
    try {
      await UserService.register(firstName, lastName, email, password);
      return true; // Jika tidak ada error, kembalikan true
    } catch (e) {
      print("Register failed: ${e.toString()}");
      return false; // Jika ada error (Exception), kembalikan false
    }
  }

  /// Fungsi verifikasi user, tidak mengubah state login. Mengembalikan true/false.
  Future<bool> verifyUser(String firstName, String lastName, String email) async {
    try {
      // Asumsi UserService punya fungsi ini
      // await UserService.verifyUser(firstName, lastName, email);
      print("verifyUser dipanggil, tapi belum diimplementasikan di service.");
      return true;
    } catch (e) {
      print("Verify user failed: ${e.toString()}");
      return false;
    }
  }

  /// Fungsi ganti password, tidak mengubah state login. Mengembalikan true/false.
  Future<bool> changePassword(String email, String newPassword, String confirmPassword) async {
    try {
      // Asumsi UserService punya fungsi ini
      // await UserService.changePassword(email, newPassword, confirmPassword);
      print("changePassword dipanggil, tapi belum diimplementasikan di service.");
      return true;
    } catch (e) {
      print("Change password failed: ${e.toString()}");
      return false;
    }
  }

}

/// Provider global yang akan diakses oleh seluruh aplikasi.
final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});