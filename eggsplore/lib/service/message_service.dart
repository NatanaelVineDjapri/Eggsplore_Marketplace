import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eggsplore/model/user.dart';
import 'package:eggsplore/model/message.dart';
import 'package:eggsplore/service/user_service.dart';

class MessageService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  static Future<List<User>> _fetchInboxOnce() async {
    final token = await UserService.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/messages/inbox"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> contactsJson = data['contacts'];
      return contactsJson.map((c) => User.fromJson(c)).toList();
    } else {
      throw Exception("Gagal fetch inbox: ${response.body}");
    }
  }

  static Stream<List<User>> watchInbox() {
    final controller = StreamController<List<User>>();
    Timer? timer;

    final fetch = () async {
      try {
        final contacts = await _fetchInboxOnce();
        // Emit data terbaru ke Stream
        controller.sink.add(contacts);
      } catch (e) {
        // Emit error ke Stream jika gagal
        controller.sink.addError(e);
      }
    };

    fetch();
    timer = Timer.periodic(const Duration(seconds: 5), (t) => fetch());
    controller.onCancel = () {
      timer?.cancel();
      controller.close();
    };

    return controller.stream;
  }

  static Future<List<Message>> getMessages(int userId) async {
    final token = await UserService.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/messages/$userId"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> messagesJson = data['messages'];
      return messagesJson.map((m) => Message.fromJson(m)).toList();
    } else {
      throw Exception("Gagal fetch messages: ${response.body}");
    }
  }

  static Future<Message?> sendMessage(int userId, String text) async {
    final token = await UserService.getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/messages/$userId"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"message": text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Message.fromJson(data['message']);
    } else {
      throw Exception("Gagal kirim pesan: ${response.body}");
    }
  }

  static Future<bool> deleteMessage(int userId, int messageId) async {
    final token = await UserService.getToken();
    final response = await http.delete(
      Uri.parse("$baseUrl/messages/$userId/$messageId"),
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode == 200;
  }
}
