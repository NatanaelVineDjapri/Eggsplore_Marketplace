import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eggsplore/model/message.dart';
import 'package:eggsplore/service/user_service.dart';

class MessageService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  static Future<Map<String, dynamic>?> getInbox({String? search}) async {
    final token = await UserService.getToken();
    if (token == null) return null;

    final url = Uri.parse("$baseUrl/messages/inbox${search != null ? '?search=$search' : ''}");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<List<Message>> getMessages(int userId) async {
    final token = await UserService.getToken();
    if (token == null) return [];

    final url = Uri.parse("$baseUrl/messages/$userId");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List messagesJson = data['messages'];
      return messagesJson.map((m) => Message.fromJson(m)).toList();
    }
    return [];
  }

  static Future<Message?> sendMessage(int userId, String text) async {
    final token = await UserService.getToken();
    if (token == null) return null;

    final url = Uri.parse("$baseUrl/messages/$userId");
    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"message": text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Message.fromJson(data['message']);
    }
    return null;
  }

  static Future<bool> deleteMessage(int userId, int messageId) async {
    final token = await UserService.getToken();
    if (token == null) return false;

    final url = Uri.parse("$baseUrl/messages/$userId/$messageId");
    final response = await http.delete(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    return response.statusCode == 200;
  }
}
