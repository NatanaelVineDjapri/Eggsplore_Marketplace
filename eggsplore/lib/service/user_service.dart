import 'dart:convert';
import 'package:eggsplore/model/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // Ambil user by ID
  static Future<User?> getUser(int id) async {
    var url = Uri.parse('$baseUrl/user/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return User.fromJson(json);
    }
    return null;
  }

  // Register user
  static Future<bool> register(String firstname,String lastname, String email, String password) async {
    var url = Uri.parse('$baseUrl/register');

    
    var response = await http.post(url, body: {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
    });

    print(response.statusCode);
    print(response.body);

    return response.statusCode == 200;
  }

  
  static Future<User?> login(String email, String password) async {
    var url = Uri.parse('$baseUrl/login');
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body); //ambil object usernya doang,klo misal diluar ad msg dll
      return User.fromJson(json['user']); //kirim ke flutter biar bs dipake
    }
    return null;
  }
}
