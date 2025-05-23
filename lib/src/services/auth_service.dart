import 'dart:convert';
import 'package:dresscode/src/constants/api.dart';
import 'package:http/http.dart' as http;

class AuthService {
  ApiConstants apiConstants = ApiConstants();
  String baseUrl = ApiConstants.baseUrl;

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      final token = responseData['accessToken'] as String;
      return token;
    } else {
      throw Exception('Échec de connexion: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      // Vérification de type explicite
      if (responseData.containsKey('message')) {
        final message = responseData['message'] as String?;
        if (message != null && message.contains('User profile')) {
          return {
            '_id': message.replaceFirst('User profile ', ''),
            'name': 'Unknown',
            'email': 'unknown@email.com',
          };
        }
      }

      // Retourne les données telles quelles si le format est différent
      return responseData;
    } else {
      throw Exception(
          'Échec de récupération des informations utilisateur: ${response.body}');
    }
  }

  Future<bool> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Échec d'inscription: ${response.body}");
    }
  }
}
