import 'dart:convert';
import 'package:eggsplore/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // ---------- TOKEN MANAGEMENT ----------
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<String?> getToken() async {
    return _getToken();
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // ---------- REGISTER ----------
  static Future<bool> register(
    String firstname,
    String lastname,
    String email,
    String password,
  ) async {
    var url = Uri.parse('$baseUrl/register');

    var response = await http.post(
      url,
      body: {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
      },
    );

    print("REGISTER => ${response.statusCode} : ${response.body}");
    return response.statusCode == 200 || response.statusCode == 201;
  }

  // ---------- LOGIN ----------
  static Future<User?> login(String email, String password) async {
    var url = Uri.parse('$baseUrl/login');
    var response = await http.post(
      url,
      body: {'email': email, 'password': password},
    );

    print("LOGIN => ${response.statusCode} : ${response.body}");

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      String token = json['token'];
      await _saveToken(token);

      // Parse user dari JSON
      return User.fromJson(json['user']);
    }
    return null;
  }

  // ---------- GET USER BY ID ----------
  static Future<User?> getUser(int id) async {
    var token = await _getToken();
    var url = Uri.parse('$baseUrl/user/$id');

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );

    print("GET USER => ${response.statusCode} : ${response.body}");

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return User.fromJson(json);
    }
    return null;
  }

  // ---------- GET CURRENT AUTHENTICATED USER (VIA TOKEN) ----------
  static Future<User?> getCurrentUser() async {
    var token = await _getToken();

    if (token == null) {
      return null;
    }

    var url = Uri.parse('$baseUrl/user');

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return User.fromJson(json);
    }

    if (response.statusCode == 401) {
      await logout();
    }
    return null;
  }

  // ---------- UPDATE USER PROFILE ----------
 // ... di dalam class UserService

  static Future<bool> updateUserProfile(Map<String, dynamic> userData, {String? imagePath}) async {
    final token = await _getToken();
    if (token == null) return false;

    final url = Uri.parse('$baseUrl/user/profile');
    
    // Use POST method and specify _method as PUT
    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';

    // Add a field to tell Laravel to treat this as a PUT request
    request.fields['_method'] = 'PUT';

    // Add the user data fields
    userData.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Add the image file if it exists
    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    }

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    print("UPDATE PROFILE => ${response.statusCode} : $responseBody");

    return response.statusCode == 200;
  }

// ... the rest of the UserService class remains the same

  // ---------- VERIFY USER ----------
  static Future<bool> verifyUser(String firstname, String lastname, String email) async {
    final url = Uri.parse('$baseUrl/verify-user');

    final response = await http.post(url, body: {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
    });

    print("VERIFY USER => ${response.statusCode} : ${response.body}");

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  // ---------- CHANGE PASSWORD ----------
  static Future<bool> changePassword(String email, String newPassword, String confirmPassword) async {
    final url = Uri.parse('$baseUrl/change-password');

    final response = await http.put(url, body: {
      'email': email,
      'newpassword': newPassword,
      'confirmpassword': confirmPassword,
    });

    print("CHANGE PASSWORD => ${response.statusCode} : ${response.body}");

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<double?> topUp(double amount) async {
    final token = await getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/topup');
    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"amount": amount}),
    );

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return double.tryParse(json['balance'].toString()) ?? 0.0;
    }

    return null;
  }
}