import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eggsplore/model/message.dart'; // isi Message & UserChat
import 'package:eggsplore/service/user_service.dart'; // buat ambil token

class MessageService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // ambil daftar kontak (inbox)
  static Future<List<UserChat>> getInbox() async {
    final token = await UserService.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/messages/inbox"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> contactsJson = data['contacts'];
      return contactsJson.map((c) => UserChat.fromJson(c)).toList();
    } else {
      throw Exception("Gagal fetch inbox: ${response.body}");
    }
  }

  // ambil semua pesan dengan user tertentu
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

  // kirim pesan
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

  // hapus pesan
  static Future<bool> deleteMessage(int userId, int messageId) async {
    final token = await UserService.getToken();
    final response = await http.delete(
      Uri.parse("$baseUrl/messages/$userId/$messageId"),
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode == 200;
  }
}
