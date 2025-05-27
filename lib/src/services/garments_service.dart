import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dresscode/src/constants/api.dart';
import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/services/api/api_service.dart';

class GarmentsService {
  GarmentsService(this._apiClient);

  final ApiService _apiClient;

  Future<List<Garment>> getGarments() async {
    final response = await _apiClient.get(ApiConstants.garmentEndpoint);
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data.map(
        (garment) => Garment.fromJSON(
          garment as Map<String, dynamic>
        )
      ).toList();
    } else {
      throw Exception(
        'Failed to load garments from API{${response.statusCode}}');
    }
  }

  Future<Garment> uploadGarmentPhoto({
    required File imageFile,
    String? description,
  }) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'garment_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      });
      final response = await _apiClient.post(
        ApiConstants.garmentEndpoint,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Garment.fromJSON(response.data as Map<String, dynamic>);
      } else {
        throw Exception("Échec de l'upload: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 413) {
        throw Exception('Image trop volumineuse');
      } else if (e.response?.statusCode == 400) {
        throw Exception("Format d'image invalide");
      } else {
        throw Exception('Erreur réseau: ${e.message}');
      }
    } catch (e) {
      throw Exception('Erreur inattendue: $e');
    }
  }
}
