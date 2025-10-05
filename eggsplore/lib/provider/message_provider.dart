import 'package:eggsplore/model/user.dart'; 
import 'package:eggsplore/service/message_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final chatProvider = StreamProvider<List<User>>((ref) {
  return MessageService.watchInbox();
});
