import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/service/user_service.dart';

class AuthNotifier extends AsyncNotifier<User?> {
  bool get isLoading => state.isLoading;
  @override
  Future<User?> build() async {
    try {
      return await UserService.getCurrentUser();
    } catch (e) {
      print("Auth build error: ${e.toString()}");
      return null;
    }
  }

  Future<bool> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await UserService.login(email, password);
    });
    return state.hasError == false; 
  }

  Future<void> logout() async {
    await UserService.logout();
    state = const AsyncData(null); 
  }

  Future<void> loadUser() async {
    ref.invalidateSelf();
    await future;
  }

  Future<bool> register(String firstName, String lastName, String email, String password) async {
    try {
      await UserService.register(firstName, lastName, email, password);
      return true;
    } catch (e) {
      print("Register failed: ${e.toString()}");
      return false; 
    }
  }

  Future<bool> verifyUser(String firstName, String lastName, String email) async {
    final success = await UserService.verifyUser(firstName, lastName, email);
    return success;
  }

  Future<bool> changePassword(
      String email, String newPassword, String confirmPassword) async {
    try {
      final success = await UserService.changePassword(
          email, newPassword, confirmPassword);
      return success;
    } catch (e) {
      print("Change password failed: ${e.toString()}");
      return false;
    }
  }

}

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});
