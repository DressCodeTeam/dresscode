import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/models/outfit.model.dart';
import 'package:dresscode/src/services/api/api_service.dart';
import 'package:dresscode/src/constants/api.dart';

class OutfitsService {
  OutfitsService(this._apiClient);
  final ApiService _apiClient;

  // Liste de tous les outfits
  Future<List<Outfit>> getOutfits() async {
    final response = await _apiClient.get(ApiConstants.findAllOutfitsEndpoint);

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data
          .map((outfit) => Outfit.fromJSON(outfit as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
          'Failed to load outfits from API{${response.statusCode}}');
    }
  }

  // Créer un nouvel outfit
  Future<Outfit> createOutfit(int styleId, List<Garment> garments) async {
    try {
      final payload = {
        'style_id': styleId,
        'garment_ids':
            garments.map((g) => g.id).where((id) => id != null).toList(),
      };

      // Debug crucial - affiche le payload exact
      print('╔═══════════════════════════════════════════');
      print('╟─ PAYLOAD ENVOYÉ À L\'API:');
      print('╟─ Endpoint: ${ApiConstants.createOutfitEndpoint}');
      print('╟─ Method: POST');
      print('╟─ Headers: {Content-Type: application/json}');
      print('╟─ Body:');
      print(jsonEncode(payload));
      print('╚═══════════════════════════════════════════');

      final response = await _apiClient.post(
        ApiConstants.createOutfitEndpoint,
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      // Debug de la réponse
      print('╔═══════════════════════════════════════════');
      print('╟─ RÉPONSE DE L\'API:');
      print('╟─ Status: ${response.statusCode}');
      print('╟─ Body: ${response.data}');
      print('╚═══════════════════════════════════════════');

      if (response.statusCode == 201) {
        try {
          final responseData = response.data as Map<String, dynamic>;
          return Outfit.fromJSON(responseData);
        } catch (e) {
          print('Erreur de parsing: $e');
          print('Données reçues: ${response.data}');
          rethrow;
        }
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.data}');
      }
    } catch (e) {
      print('Erreur lors de la création: $e');
      rethrow;
    }
  }

  // Récupérer un outfit par ID
  Future<List<Garment>> getOutfitById(int id) async {
    final response =
        await _apiClient.get('${ApiConstants.findOutfitByIdEndpoint}/$id');

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data
          .map((garment) => Garment.fromJSON(garment as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load outfit by ID: ${response.statusCode}');
    }
  }

  // Generer un outfit avec l'IA
  Future<List<Outfit>> generateOutfits({
    required int nbOutfits,
    required int styleId,
    required String weather,
  }) async {
    try {
      final payload = {
        'nb_outfits': nbOutfits,
        'style_id': styleId,
        'weather': weather,
      };

      print('Payload envoyé pour la génération d\'outfits : $payload');

      final response = await _apiClient.post(
        ApiConstants.generateOutfitsEndpoint,
        data: payload,
      );

      print(
          'Réponse de l\'API pour la génération d\'outfits : ${response.data}');

      if (response.statusCode == 201) {
        final data = response.data as List<dynamic>;
        return data.map((outfitData) {
          return Outfit.fromJSON(
            outfitData as Map<String, dynamic>,
          );
        }).toList();
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.data}');
      }
    } catch (e) {
      print('Erreur lors de la génération des outfits : $e');
      rethrow;
    }
  }

  // Supprimer un outfit par ID
  Future<void> deleteOutfit(String id) async {
    await _apiClient.delete('${ApiConstants.findOutfitByIdEndpoint}/$id');
  }
}
