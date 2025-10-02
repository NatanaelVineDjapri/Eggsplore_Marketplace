import 'package:eggsplore/model/like_model.dart';
import 'package:eggsplore/model/product.dart';
import 'package:eggsplore/service/like_service.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Service provider
final likeServiceProvider = Provider<LikeService>((ref) => LikeService());

// State provider
final likeStateProvider = StateNotifierProvider<LikeNotifier, Map<int, Like>>((ref) {
  final service = ref.watch(likeServiceProvider);
  return LikeNotifier(service, ref);
});

// StateNotifier class
class LikeNotifier extends StateNotifier<Map<int, Like>> {
  final LikeService service;
  final Ref ref;

  LikeNotifier(this.service, this.ref) : super({});

  Like? getLike(int productId) => state[productId];

  Future<void> toggleLike(int productId) async {
    try {
      final token = await UserService.getToken();
      if (token == null || token.isEmpty) throw Exception('User not logged in');

      final updatedLike = await service.toggleLike(productId, token);
      if (updatedLike != null) {
        state = {...state, productId: updatedLike};

        // Refresh likedProductsProvider supaya wishlist update
        ref.invalidate(likedProductsProvider);
      }
    } catch (e) {
      print('Toggle like error: $e');
    }
  }
}

// Liked products provider
final likedProductsProvider = FutureProvider<List<Product>>((ref) async {
  final service = LikeService();
  return service.fetchLikedProducts();
});
