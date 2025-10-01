import 'package:eggsplore/model/like_model.dart';
import 'package:eggsplore/service/like_service.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final likeServiceProvider = Provider<LikeService>((ref) => LikeService());

final likeStateProvider = StateNotifierProvider<LikeNotifier, Map<int, Like>>((ref) {
  final service = ref.watch(likeServiceProvider);
  return LikeNotifier(service);
});

class LikeNotifier extends StateNotifier<Map<int, Like>> {
  final LikeService service;

  LikeNotifier(this.service) : super({});

  Like? getLike(int productId) => state[productId];

  Future<void> toggleLike(int productId) async {
    try {
      // Ambil token dari UserService
      final token = await UserService.getToken();
      if (token == null || token.isEmpty) throw Exception('User not logged in');

      final updatedLike = await service.toggleLike(productId, token);
      if (updatedLike != null) {
        state = {...state, productId: updatedLike};
      }
    } catch (e) {
      print('Toggle like error: $e');
    }
  }
}
