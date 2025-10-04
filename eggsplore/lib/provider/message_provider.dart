import 'package:eggsplore/model/message.dart';
import 'package:eggsplore/service/message_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = FutureProvider<List<UserChat>>((ref) async {
  return await MessageService.getInbox();
});
