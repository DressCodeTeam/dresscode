import 'dart:convert';
import 'package:dresscode/src/models/garment.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'https://dresscode-api.onrender.com';

  Future<List<Garment>> fetchGarments() async {
    final url = Uri.parse('$baseUrl/garments');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data.map((json) => Garment.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Échec de la récupération des vêtements : ${response.body}');
    }
  }

  Future<http.Response> createOutfit({
    required List<String> garmentIds,
    required String styleId,
  }) async {
    final url = Uri.parse('$baseUrl/outfits');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode({
      'garments': garmentIds,
      'style_id': styleId,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception('Échec de la création de l’outfit : ${response.body}');
    }
  }
}
